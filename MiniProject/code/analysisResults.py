#!/usr/bin/env python3

"""Analsing the models and model fitting results for miniproject"""
__appname__ = 'data_prepro'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '3.10.7'
__license__ = "None"

# import the required packages
import numpy as np
import pandas as pd
import os
modelName = ["Cubic", "Logistic", "GenLogistic", "Gompetza", "Hybrid"]


def getCriterions(path):
    """ Get the AICc, BIC, Akaike and Schwarz weight and R^2 values of each model

    Parameters
    ----------
    path : strings
        Path of pending read (.csv) file 

    Returns
    ----------
    Aicc : pd.Dataframe
        a tuple of the values of AICc calculated for each models
    Bic : pd.Dataframe
        a tuple of the values of BIC calculated for each models
    box_data_Aicc_weight : pd.Dataframe
        a tuple of the values of Akaike weight calculated of AICc of each models
    box_data_Bic_weight : pd.Dataframe
        a tuple of the values of Schwarz weight calculated of BIC of each models
    box_data_R2 : pd.Dataframe
        a tuple of the values of R^1 calculated for each models
    """
    criterionFile = [
        f"{path}/{modelName[i]}_Criterion.csv" for i in range(len(modelName))]

    Aicc = []  # Store the AICc of each model
    Bic = []  # Store the BIC of each model
    box_data_Aicc_weight = []  # Store the Akaike weight of each model
    box_data_Bic_weight = []  # Store the Schwarz weight of each model
    box_data_R2 = []  # Store the R^2 of each model
    for i in range(len(criterionFile)):
        data = pd.read_csv(criterionFile[i])
        Aicc.append(data.iloc[:, 1].values)
        Bic.append(data.iloc[:, 2].values)
        box_data_Aicc_weight.append(data.iloc[:, 3].values)
        box_data_Bic_weight.append(data.iloc[:, 4].values)
        box_data_R2.append(data.iloc[:, 5].values)

    Aicc = np.array(Aicc).T
    Bic = np.array(Bic).T
    box_data_Aicc_weight = np.array(box_data_Aicc_weight).T
    box_data_Bic_weight = np.array(box_data_Bic_weight).T
    box_data_R2 = np.array(box_data_R2).T
    return [Aicc, Bic, box_data_Aicc_weight, box_data_Bic_weight, box_data_R2]


def countTimes(criterion, positive=False):
    """ Count the number the candidate model is picked as the best fit (the lowest AICc and BIC value)

    Parameters
    ----------
    criterion : pd.Dataframe
        the AICc and BIC values of each model fit
    positive : bool
        defaults to False

    Returns
    ----------
    countRes: pd.Dataframe
        the numbers of each model was counted as the best fit  
    """
    count = [0 for i in range(len(modelName))]
    if positive:
        best = np.argmax(criterion, axis=1)
    else:
        best = np.argmin(criterion, axis=1)
    for i in np.unique(best):
        count[i] = np.sum((best == i))
    countRes = dict(zip(modelName, count))
    return countRes


def getMeanStd(criterion):
    """ Calculate the mean and standard deviation of AICc, BIC, Akaike and Schwarz weight and R^2 
    Parameters
    ----------
    criterion : pd.Dataframe
        the criterion values of each model fit

    Returns
    ----------
    mean : pd.Dataframe
        the mean of criterions of each model
    std : pd.Dataframe
        the standard deviation of criterions of each model
    """
    mean = criterion.mean(axis=0)
    std = criterion.std(axis=0)
    return (mean, std)


def analysis(path, criPath):
    """ Analysis the model performance under different criterions

    Parameters
    ----------
    path path : strings
        Path of pending read (.csv) file 
    criPath : strings
        Path of pending criterions
    """
    criterionList = ["Aicc", "Bic", "AkaikeWeight", "SchwarzWeight"]
    criterions = getCriterions(path)
    for i in range(len(criterionList)):
        if i in [2, 3]:
            count = countTimes(criterions[i], positive=True)
        else:
            count = countTimes(criterions[i], positive=False)
        print(f"{criterionList[i]}'s count result: ")
        print(count)
        if i in [2, 3]:
            # Analyse the mean and standard deviation of Akaike Weight and Schwarz Weight
            print(f"{criterionList[i]}'s mean and std result: ")
            print(getMeanStd(criterions[i]))
        print("="*20)
    # Save the results of each criterion
    criList = criterionList+["R2"]
    if not os.path.exists(criPath):
        os.mkdir(criPath)
    for i in range(len(criterions)):
        temp = pd.DataFrame(criterions[i], columns=modelName)
        temp.to_csv(f"{criPath}/{criList[i]}.csv", index=False)

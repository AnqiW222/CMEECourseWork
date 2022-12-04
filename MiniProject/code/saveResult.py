#!/usr/bin/env python3

"""Save the model fitting results for miniproject"""
__appname__ = 'data_prepro'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '3.10.7'
__license__ = "None"

# import the required packages and scripts
import pandas as pd
import os
from defineModel import *


def __sst(y_no_fitting):
    """ Calculate the total sum of squares (SST)
    
    Parameters
    ----------
    y_no_predicted: List[int] or array[int]
        'y' to be fitted
    
    Returns
    ----------
    sst : pd.Dataframe
        the total sum of squares (SST)
    """
    y_mean = np.sum(y_no_fitting) / len(y_no_fitting)
    sst = np.sum(np.square(y_mean-y_no_fitting))
    return sst


def __ssr(y_fitting, y_no_fitting):
    """ Calculate the regression sum of squares (SSR)
    
    Parameters
    ----------
    y_fitting : List[int] or array[int]
        the fitted y
    y_no_fitting : List[int] or array[int] 
        'y' to be fitted
    
    Returns
    ----------
    ssr : pd.Dataframe
        regression sum of squares
    """
    y_mean = np.sum(y_no_fitting) / len(y_no_fitting)
    ssr = np.sum(np.square(y_mean-y_fitting))
    return ssr


def goodness_of_fit(pred, real):
    """ Calculate the goodness of fit - R^2
    
    Paramaters
    ----------
    y_fitting : List[int] or array[int] 
        the fitted y
    y_no_fitting : List[int] or array[int] 
        'y' to be fitted
    
    Returns
    ----------
    rr : pd.Dataframe
        the goodness of fit - R^2
    """
    rr = 1 - np.sum(np.square(pred-real))/np.sum(np.square(real-np.mean(real)))
    return rr


def save(splitData, saveCriterionPath, saveFitPath):
    """ Save all results

    Parameters
    ----------
    splitData : List
        a list of dataframe of modified data
    saveCriterionPath : string
        a path where save the Criterions results
    saveFitPath : string
        a path where save the Model fitting results

    Returns
    ----------
    criterionDataframeList : List
        a list of model criterions saving results
    """
    modelName = ["Cubic", "Logistic", "GenLogistic", "Gompetza", "Hybrid"]

    # saveCriterionPath = "Criterion"
    # saveFitPath = "Fit"
    # Create the Dataframe of Criterion
    criterionDataframe = pd.DataFrame()
    criterionDataframe["Number"] = range(1, len(splitData) + 1)
    criterionDataframe["AICc"] = range(1, len(splitData) + 1)
    criterionDataframe["BIC"] = range(1, len(splitData) + 1)
    criterionDataframe["AICc_weight"] = range(1, len(splitData) + 1)
    criterionDataframe["BIC_weight"] = range(1, len(splitData) + 1)
    criterionDataframe["RSquare"] = range(1, len(splitData) + 1)
    # criterionDataframe["Species"] = "None"
    criterionDataframeList = [criterionDataframe.copy()
                              for i in range(len(modelName))]

    if not os.path.exists(saveCriterionPath):
        os.mkdir(saveCriterionPath)
    if not os.path.exists(saveFitPath):
        os.mkdir(saveFitPath)

    for i in range(len(splitData)):
        fitResult, criterion = fitModel(splitData[i])
        # Calculate Akaike weight and Schwarz weight
        cri = np.array(criterion)
        delta = cri-np.min(cri, axis=0)
        weight = np.exp(-1/2*delta)/np.sum(np.exp(-1/2*delta), axis=0)

        # Save Criterion
        for j in range(len(criterionDataframeList)):
            criterionDataframeList[j].iloc[i, :] = [i+1] + \
                list(criterion[j]) + list(weight[j, :]) + \
                [goodness_of_fit(fitResult[j], splitData[i].iloc[:, 1])]

        # Save Model fitting results
        fitResultDatafram = pd.DataFrame()
        fitResultDatafram["Time"] = splitData[i].iloc[:, 0]
        fitResultDatafram["PopBio"] = splitData[i].iloc[:, 1]
        for j in range(len(modelName)):
            fitResultDatafram[modelName[j]] = fitResult[j]
        fitResultDatafram.to_csv(
            f"{saveFitPath}/{i+1}_Fit.csv", index=False)

    # Save Criterion results
    for i in range(len(criterionDataframeList)):
        criterionDataframeList[i].to_csv(
            f"{saveCriterionPath}/{modelName[i]}_Criterion.csv", index=False)
    return criterionDataframeList

#!/usr/bin/env python3

"""Data preprocessing for miniproject"""
__appname__ = 'data_prepro'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '3.10.7'
__license__ = "None"

# insert required package and scripts
import pandas as pd
from defineModel import *

def readData(path):
    """ Read data and create dataframe
    
    Parameters
    ----------
    path : strings
        Path of pending read (.csv) file 

    Returns
    ----------
    temp_data : pd.Dataframe
        the dataframe of the read file
    """
    data = pd.read_csv(path)
    temp_data = data.copy()

    return temp_data


def delRow(temp_data):
    """ Delete rows containing invaild data from the dataframe
    
    Parameters
    ----------
    temp_data : pd.Dataframe
        the dataframe of input file
        
    Returns
    ----------
    temp_data_p1 : pd.Dataframe
        the modified dataframe 
    """
    # Delete rows with missing values for Time and PopBio
    temp_data = temp_data.dropna(subset=["Time", "PopBio"])
    # Delete the rows contains negative or 0 population
    temp_data_p1 = temp_data.drop(
        index=temp_data[(temp_data["PopBio"] < 0) | (temp_data["PopBio"] == 0)].index)
    # Re-value the negative time to be 0
    def f(x): return x if x >= 0 else 0
    temp_data_p1["Time"] = temp_data_p1["Time"].map(f)
    return temp_data_p1


def group(temp_data_p1):
    """ Grouping the data by the experiment

    Parameters
    ----------
    temp_data_p1 : pd.Dataframe
        the modified dataframe deleting all rows containing the invaild data

    Returns
    ----------
    splitData : list
        a list containing dataframes of Time, PopBio and Species
    """
    start = 0
    end = 0
    splitData = []
    # Using for loop and empty list to achieve 'pointer', grouping and cleaning the data at the same time
    for i in range(len(temp_data_p1)):
        if temp_data_p1.iloc[i, 1] != 0:
            end = end + 1
        else:
            # Only the Time, PopBio and Species columns are selected and processed in reverse order
            splitData.append(temp_data_p1.iloc[start:end + 1, [1, 2, 6]][::-1])
            start = end + 1
            end = start
    splitTemp = splitData.copy()
    splitData = [i.sort_values("Time") for i in splitTemp if len(i) > 7]
    return splitData


def delFitFail(splitData):
    """ First attempt to exclude unfitted data

    Parameters
    ----------
    splitData : list
        a list containing dataframes of Time, PopBio and Species

    Returns
    ---------
    splitDataNew : list
        a new list containing dataframes of Time, PopBio and Species excludes the unfitted ones
    """
    splitDataNew = []
    errorList = []
    for i in range(len(splitData)):
        try:
            Model, criterion = fitModel(splitData[i])
            splitDataNew.append(splitData[i])
        except:
            print("!!!!CAN NOT BE FITTED, REMOVED!!!!  ", i)
            errorList.append(i)
    print(f"{len(errorList)} datasets could not be fitted in total!")
    print(f"Now {len(splitDataNew)} datasets were left")
    return splitDataNew


def dataProcess(path):
    """ The whole data pre - processing process
    
    Parameters
    ----------
    path : strings
        Path of pending read (.csv) file 

    Returns
    ----------
    splitDataNew : list
        completed list containing modified datasets of Time, PopBio and Species
    """
    # Read the data
    temp_data = readData(path)
    # Delete the invaild rows
    temp_data_p1 = delRow(temp_data)
    # Group the data
    splitData = group(temp_data_p1)
    # Delete the unfitted data
    splitDataNew = delFitFail(splitData)
    return splitDataNew

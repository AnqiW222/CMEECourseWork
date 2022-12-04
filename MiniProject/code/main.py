#!/usr/bin/env python3

"""Running Python code for miniproject"""
__appname__ = 'data_prepro'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '3.10.7'
__license__ = "None"

# insert python code
import dataPreprocessing
import defineModel
import saveResult
import analysisResults

# Data Preprocessing
print("="*20)
print("Start Modifying the data!")
dataPath = "../data/LogisticGrowthData.csv"
splitData = dataPreprocessing.dataProcess(dataPath)
print("Data Modifying Finished!")
print("="*20)

print("="*20)
print("Start fitting the models and saving the calculation results!")
# Model fit and save
# Five Model names
modelName = ["Cubic", "Logistic", "GenLogistic", "Gompetza","Hybrid"]
# Saving Path
saveCriterionPath = "../results/ModelPerformance"
saveFitPath = "../results/FitResults"
criterion = saveResult.save(splitData,saveCriterionPath,saveFitPath)
print("Model Fitting Finished! Save the results... DONE!")
print("="*20)

print("="*20)
print("Start Analysing the Results!")
# Analyse the results
# The saving path of criterions results
criPath = "../results/Criterion"
analysisResults.analysis(saveCriterionPath, criPath)
print("Results Analysis Finished!")
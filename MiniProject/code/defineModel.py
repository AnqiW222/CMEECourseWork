#!/usr/bin/env python3

"""Defining models and model fitting functions for miniproject"""
__appname__ = 'data_prepro'
__author__ = 'ANQI WANG (aw222@ic.ac.uk)'
__version__ = '3.10.7'
__license__ = "None"

# import the required packages
from lmfit import Minimizer, Parameters, report_fit
import pandas as pd
import numpy as np
import scipy.optimize as sco


def CubicModel(test):
    """ Define the Cubic Model (Linear Model) to the data and subtract data

    Parameters
    ----------
    test : pd.Dataframe
        a tuple read from splitData as a dataframe use to test the Cubic Model

    Returns
    ----------
    fit_Cubic : pd. Dataframe
        a dataframe of model fit results
    """
    # Create object for storing parameters
    params_linear = Parameters()

    # Add parameters and initial values to it
    params_linear.add('a', value=1)
    params_linear.add('b', value=1)
    params_linear.add('c', value=1)
    params_linear.add('d', value=1)

    # Write down the objective function that we want to minimize, i.e., the residuals
    def residuals_linear(params, t, data):
        """Calculate cubic growth and subtract data
        
        Parameters
        ----------
        params : dic
            defined estimator parameters 
        t : pd.Dataframe
            dataframe of time read from test
        data : pd.Dataframe
            dataframe of PopBio data
            
        Returns
        ----------
        model - data : pd.Dataframe
            residuals - minimising the objective function 
        """
        # Get an ordered dictionary of parameter values
        v = params.valuesdict()
        # Cubic model
        model = v['a']*t**3 + v['b']*t**2 + v['c']*t + v['d']
        return model - data  # Return residuals
    # Create a Minimizer object
    minner = Minimizer(residuals_linear, params_linear,
                       fcn_args=(test.iloc[:, 0].values, test.iloc[:, 1].values))

    # Perform the minimization
    fit_Cubic = minner.minimize()

    return fit_Cubic


def LogisticModel(test):
    """ Define the Logistic Model (Non-Linear Model) to the data and subtract data

    Parameters
    ----------
    test : pd.Dataframe
        a tuple read from splitData as a dataframe use to test the Logistic Model

    Returns
    ----------
    fit_logistic : pd. Dataframe
        a dataframe of model fit results
    """
    # Create object for parameter storing
    params_logistic = Parameters()
    params_logistic.add('N_0', value=test.iloc[0, 1])
    params_logistic.add('N_max', value=test.iloc[-1, 1])
    # Recall the value for growth rate obtained from a linear fit
    params_logistic.add('r', value=0.62)

    # Write down the objective function that we want to minimize, i.e., the residuals
    def residuals_logistic(params, t, data):
        ''' Calculate logistic growth and subtract data
        
        Parameters
        ----------
        params : dic
            defined estimator parameters 
        t : pd.Dataframe
            dataframe of time read from test
        data : pd.Dataframe
            dataframe of PopBio data
            
        Returns
        ----------
        model - data : pd.Dataframe
            residuals - minimising the objective function 
        '''
        # Get an ordered dictionary of parameter values
        v = params.valuesdict()
        # Logistic model
        model = v['N_0'] * v['N_max'] * np.exp(v['r']*t) / \
            (v['N_max'] + v['N_0'] * (np.exp(v['r']*t) - 1))
        # Return residuals
        return model - data
    # Create a Minimizer object
    minner = Minimizer(residuals_logistic, params_logistic,
                       fcn_args=(test.iloc[:, 0].values, test.iloc[:, 1].values))  # Plug in the logged data.
    # Perform the minimization
    fit_logistic = minner.minimize(method='leastsq')

    return fit_logistic


def GenlogisticModel(test):
    """ Define the Generalised Logistic Model (Non-Linear Model) to the data and subtract data

    Parameters
    ----------
    test : pd.Dataframe
        a tuple read from splitData as a dataframe use to test the Generalised Logistic Model

    Returns
    ----------
    fit_genlogistic : pd. Dataframe
        a dataframe of model fit results
    """
    # Define the parameter object
    params_genlogistic = Parameters()
    # Add parameters and initial values
    params_genlogistic.add('A', value=0.1, min=0)
    params_genlogistic.add('K', value=0.1, min=0)
    params_genlogistic.add('Q', value=0.1, min=0)
    params_genlogistic.add('B', value=0.1, min=0)
    params_genlogistic.add('mu', value=0.1, min=0)
    params_genlogistic.add('T', value=0.1, min=0)
    # Define the model

    def residuals_genlogistic(params, t, data):
        '''Model a generalised logistic growth and subtract data
        
        Parameters
        ----------
        params : dic
            defined estimator parameters 
        t : pd.Dataframe
            dataframe of time read from test
        data : pd.Dataframe
            dataframe of PopBio data
            
        Returns
        ----------
        model - data : pd.Dataframe
            residuals - minimising the objective function
        '''
        # Get an ordered dictionary of parameter values
        v = params.valuesdict()
        # Logistic model
        model = v['A'] + (v['K'] - v['A']) / \
            (1 + v['Q'] * np.exp(-v['B']*(t-v['T'])))**(1/v['mu'])
        # Return residuals
        return model - data
    # Perform the fit
    # Create a Minimizer object
    minner = Minimizer(residuals_genlogistic, params_genlogistic,
                       fcn_args=(test.iloc[:, 0].values, test.iloc[:, 1].values))
    # Perform the minimization
    fit_genlogistic = minner.minimize()
    return fit_genlogistic


def GompetzaModel(test):
    """ Define the Gompetza Model (Non-Linear Model) to the data and subtract data

    Parameters
    ----------
    test : pd.Dataframe
        a tuple read from splitData as a dataframe use to test the Gompetza Model

    Returns
    ----------
    fit_genlogistic : pd. Dataframe
        a dataframe of model fit results
    """
    # Create object for parameter storing
    params_gompetza = Parameters()

    params_gompetza.add("N_0", value=test.iloc[0, 1])
    params_gompetza.add("N_max", value=test.iloc[-1, 1])
    params_gompetza.add("r_max", value=0.65, min=0.001)
    params_gompetza.add("t_lag", value=5, min=0)

    # Write down the objective function that we want to minimize, i.e., the residuals
    def residuals_gompetza(params, t, data):
        '''Model a gompetza growth and subtract data
        Parameters
        ----------
        params : dic
            defined estimator parameters 
        t : pd.Dataframe
            dataframe of time read from test
        data : pd.Dataframe
            dataframe of PopBio data
            
        Returns
        ----------
        model - data : pd.Dataframe
            residuals - minimising the objective function
        '''
        # Get an ordered dictionary of parameter values
        v = params.valuesdict()
        # Gompertz model
        model = v['N_0'] + (v['N_max'] - v['N_0']) * \
            np.exp(-np.exp(v['r_max'] * np.exp(1) * (v['t_lag'] - t) /
                           ((v['N_max'] - v['N_0']) * np.log(10)) + 1))
        # Return residuals
        return model - data

    # Create a Minimizer object
    minner = Minimizer(residuals_gompetza,
                       params_gompetza,
                       fcn_args=(test.iloc[:, 0].values,
                                 np.log(test.iloc[:, 1].values)))
    # Perform the minimization
    fit_gompetza = minner.minimize()
    return fit_gompetza


def individualResult(test):
    """ Define the Individual Model Fit results

    Parameters
    ----------
    test : pd.Dataframe
        a tuple read from splitData as a dataframe use to test the individual models

    Returns
    ----------
    modelFitResult : pd.Dataframe
        a dataframe of all single model fit results
    """
    modelName = ["Cubic", "Logistic", "GenLogistic", "Gompetza"]
    Model = [CubicModel(test),
             LogisticModel(test),
             GenlogisticModel(test),
             GompetzaModel(test)]
    modelFitResult = []  # Save the results of four single model fitting 
    for i in range(len(Model)):
        if i != len(Model)-1:
            fit = test.iloc[:, 1] + Model[i].residual
        else:
            fit = np.log(test.iloc[:, 1]) + Model[i].residual
            fit = np.exp(fit)
        modelFitResult.append(fit)
    return modelFitResult


def CombinationModel(test):
    """ Define the Gompetza Model (Non-Linear Model) to the data and subtract data
    
    Parameters
    ----------
    test : pd.Dataframe
        a tuple read from splitData as a dataframe use to test the individual models

    Returns
    ----------
    individualFit : pd.Dataframe
        the model fit results of four single models
    combinationFit : pd.Dataframe
        the model fit results of hybrid model
    """
    modelName = ["Cubic", "Logistic", "GenLogistic", "Gompetza"]
    modelNum = len(modelName)
    real = test.iloc[:, 1]
    individualFit = individualResult(test)  # model fit results of four single models 
    modelFit = np.array(individualFit)
    N = len(real)  # the number of datasets

    def min_mse(weight):
        """ Minimising the fit error

        Parameters
        ----------
        weight : pd.Dataframe
            the weight coefficient (weight vectors) of single model

        Returns
        ----------
        mse : pd.Dataframe
            the results calculated through the minimisation constraint sets

        """
        weight = np.array(weight).reshape(1, -1)
        y_hat = np.dot(weight, modelFit).flatten()
        mse = np.mean(np.square(real - y_hat))
        return mse

    def constraint1(weight):
        """ Calculating the constraintion of single models

        Parameters
        ----------
        weight : pd.Dataframe
            the weight coefficient (weight vectors) of single model

        Returns
        ----------
        np.sum(weight)-1 : function
            return the results of constraints
        """
        return np.sum(weight)-1
    con1 = {"type": "eq", "fun": constraint1}
    bnds = tuple((0, 1) for x in range(modelNum))
    weight0 = modelNum * [1/modelNum]
    solution = sco.minimize(min_mse, weight0, bounds=bnds, constraints=con1)
    finalWeight = solution.x  # Weights
    combinationFit = np.dot(finalWeight, modelFit)  # The results of Hybrid Model fit
    return (individualFit, combinationFit)


def calculateCriterion(real, pred, K):
    """ Calculate the Criterions of Model Fits

    Parameters
    ----------
    real : pd.Dataframe
        the data of real PopBio data over time    
    pred : pd.Dataframe
        the data of model predicting PopBio data over time
    K : int
        the estimator parameter of carring capacity
        
    Returns
    ----------
    aicc : float
        the calculation of AICc to model fitting results
    bic : float
        the calculation of BIC to model fitting results
    """
    N = len(real)
    prefix = N*np.log(np.square(pred - real).sum()/N)
    aicc = prefix+2*K+2*K*(K+1)/(N-K-1)
    bic = prefix + np.log(N)*K
    return (aicc, bic)


def fitModel(test):
    """ Arranging the model fits results and criterion calculation results

    Parameters
    ----------
    test : pd.Dataframe
        a tuple read from splitData as a dataframe use to test the Logistic Model

    Returns
    ----------
    fitResults : List[pd.Dataframe]
        the model fits results of all five models
    criterion : List[pd.Dataframe]
        the criterion results of all five model fittings
    """
    modelName = ["Cubic", "Logistic", "GenLogistic", "Gompetza", "Hybrid"]
    paramsNum = [4, 3, 6, 4, 4]
    # Obtain four individual and combined forecasts
    individualFit, combinationFit = CombinationModel(test)
    fitResult = [i.values for i in individualFit] + [combinationFit]
    criterion = []
    for i in range(len(modelName)):
        criter = calculateCriterion(real=test.iloc[:, 1].values,
                                    pred=fitResult[i],
                                    K=paramsNum[i])
        criterion.append(criter)

    return (fitResult, criterion)

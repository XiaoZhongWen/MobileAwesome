/*
 * @Author: your name
 * @Date: 2021-01-19 21:34:07
 * @LastEditTime: 2021-01-19 22:14:59
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /Github_RN/js/navigator/AppNavigator.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';
import {createSwitchNavigator, createAppContainer} from 'react-navigation';
import {createStackNavigator} from 'react-navigation-stack';
import HomePage from '../pages/HomePage';
import WelcomePage from '../pages/WelcomePage';

const InitNavigator = createStackNavigator({
    Welcome: {
        screen: WelcomePage,
        navigationOptions: {
            header: null,
        },
    },
});

const MainNavigator = createStackNavigator({
    Home: {
        screen: HomePage,
        navigationOptions: {
            header: null,
        },
    },
});

const AppNavigator = createSwitchNavigator(
    {
        Init: {
            screen: InitNavigator,
        },
        Main: {
            screen: MainNavigator,
        },
    },
    {
        navigationOptions: {
            header: null,
        },
    },
);

export default createAppContainer(AppNavigator);

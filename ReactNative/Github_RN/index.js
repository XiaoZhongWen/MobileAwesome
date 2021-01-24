/*
 * @Author: your name
 * @Date: 2021-01-18 22:56:48
 * @LastEditTime: 2021-01-19 21:49:49
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /Github_RN/index.js
 */
/**
 * @format
 */

import {AppRegistry} from 'react-native';
import {name as appName} from './app.json';
import AppNavigator from './js/navigator/AppNavigator';

AppRegistry.registerComponent(appName, () => AppNavigator);

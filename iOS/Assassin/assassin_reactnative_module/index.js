/*
 * @Author: your name
 * @Date: 2021-01-25 11:02:33
 * @LastEditTime: 2021-01-27 09:27:53
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/index.js
 */
/**
 * @format
 */

import {AppRegistry} from 'react-native';
import AppNavigator from './src/common/navigator/AppNavigator';
import {name as appName} from './app.json';

AppRegistry.registerComponent(appName, () => AppNavigator);

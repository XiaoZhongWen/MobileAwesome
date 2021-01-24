/*
 * @Author: your name
 * @Date: 2020-12-18 18:59:29
 * @LastEditTime: 2021-01-24 19:52:03
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: /Assassin_reactnative/index.js
 */
/**
 * @format
 */

import {AppRegistry} from 'react-native';
import App from './App';
import MessagePage from './js/message/MessagePage';
import {name as appName} from './app.json';

AppRegistry.registerComponent(appName, () => MessagePage);

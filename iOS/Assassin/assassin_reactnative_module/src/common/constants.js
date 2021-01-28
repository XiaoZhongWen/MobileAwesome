/*
 * @Author: your name
 * @Date: 2021-01-25 14:39:28
 * @LastEditTime: 2021-01-28 15:53:34
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/common/constants.js
 */

import {NativeModules} from 'react-native';
import {CommonDataProvider} from './AssassinModules';

export const COMMON_THEME_COLOR = CommonDataProvider.themeColor ?? 'orange';
export const COMMON_TITLE_COLOR = 'white';
export const COMMOM_NAV_BAR_ICON_SIZE = 22.0;
export const COMMOM_MARGIN = 10.0;

export const COMMON_ROUTENAME_MESSAGE = 'Message';
export const COMMON_ROUTENAME_CONTACTS = 'Contacts';
export const COMMON_ROUTENAME_CONTACTS_DETAIL = 'ContactsDetail';
export const COMMON_HEADER_SIZE = 35;

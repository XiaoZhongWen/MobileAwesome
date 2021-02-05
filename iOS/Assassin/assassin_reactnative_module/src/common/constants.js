/*
 * @Author: your name
 * @Date: 2021-01-25 14:39:28
 * @LastEditTime: 2021-02-05 15:02:30
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
export const COMMON_ROUTENAME_CHAT = 'Chat';

export const COMMON_HEADER_SIZE = 35;

export const COMMON_FONT_SIZE_LEVEL_1 = 12;
export const COMMON_FONT_SIZE_LEVEL_2 = 13;
export const COMMON_FONT_SIZE_LEVEL_3 = 14;
export const COMMON_FONT_SIZE_LEVEL_4 = 15;

export const COMMON_FONT_WEIGHT_LEVEL_1 = '300';
export const COMMON_FONT_WEIGHT_LEVEL_2 = '400';

export const COMMOM_GROUP = '_group_';

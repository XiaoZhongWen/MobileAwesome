/*
 * @Author: your name
 * @Date: 2021-01-25 16:47:49
 * @LastEditTime: 2021-01-27 14:17:50
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/common/rootReducer.js
 */

import {combineReducers} from 'redux';
import contactsReducer from '../features/contacts/redux/reducer';

const reducerMap = {
    contacts: contactsReducer,
};

export default combineReducers(reducerMap);

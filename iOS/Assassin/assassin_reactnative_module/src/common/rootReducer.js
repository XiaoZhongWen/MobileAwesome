/*
 * @Author: your name
 * @Date: 2021-01-25 16:47:49
 * @LastEditTime: 2021-02-04 16:32:37
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/common/rootReducer.js
 */

import {combineReducers} from 'redux';
import contactsReducer from '../features/contacts/redux/reducer';
import messageReducer from '../features/message/redux/reducer';

const reducerMap = {
    contacts: contactsReducer,
    messages: messageReducer,
};

export default combineReducers(reducerMap);

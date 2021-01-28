/*
 * @Author: your name
 * @Date: 2021-01-26 12:03:26
 * @LastEditTime: 2021-01-26 12:12:26
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/contacts/redux/reducer.js
 */

import initialState from './initialState';
import {reducer as fetchContactsListReducer} from './fetchContactsList';

const reducers = [fetchContactsListReducer];

export default function reducer(state = initialState, action) {
    let newState;
    switch (action.type) {
        // Handle cross-topic actions here
        default:
            newState = state;
            break;
    }
    return reducers.reduce((s, r) => r(s, action), newState);
}

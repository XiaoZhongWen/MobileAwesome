/*
 * @Author: your name
 * @Date: 2021-01-26 12:07:54
 * @LastEditTime: 2021-01-27 14:04:11
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/contacts/redux/fetchContactsList.js
 */

import {ContactsDataProvider} from '../../../common/AssassinModules';
import {
    CONSTANTS_FETCH_LIST_BEGIN,
    CONSTANTS_FETCH_LIST_SUCCESS,
    CONSTANTS_FETCH_LIST_FAILURE,
} from './constants';

export function fetchContactsList() {
    return (dispatch) => {
        dispatch({
            type: CONSTANTS_FETCH_LIST_BEGIN,
        });
        ContactsDataProvider.fetchContactsList().then(
            function (result) {
                let list = JSON.parse(result);
                dispatch({
                    type: CONSTANTS_FETCH_LIST_SUCCESS,
                    contactsList: list,
                });
            },
            function (error) {
                dispatch({
                    type: CONSTANTS_FETCH_LIST_FAILURE,
                    fetchContactsListError: error,
                });
            },
        );
    };
}

export function reducer(state, action) {
    switch (action.type) {
        case CONSTANTS_FETCH_LIST_BEGIN:
            return {
                ...state,
                fetchContactsListPending: true,
            };
        case CONSTANTS_FETCH_LIST_SUCCESS:
            return {
                ...state,
                contactsList: action.contactsList,
                fetchContactsListPending: false,
            };
        case CONSTANTS_FETCH_LIST_FAILURE:
            return {
                ...state,
                fetchContactsListPending: false,
                fetchContactsListError: action.fetchContactsListError,
            };
        default:
            return state;
    }
}

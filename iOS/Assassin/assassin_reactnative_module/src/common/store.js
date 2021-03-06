/*
 * @Author: your name
 * @Date: 2021-01-25 16:46:07
 * @LastEditTime: 2021-02-04 17:38:21
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/common/store.js
 */

import {createStore, applyMiddleware, compose} from 'redux';
import {composeWithDevTools} from 'redux-devtools-extension';
import thunk from 'redux-thunk';
import rootReducer from './rootReducer';
import {reducer as fetchContactsListReducer} from '../features/contacts/redux/reducer';

const middlewares = [thunk];

function configureStore(initialState) {
    const store = createStore(
        rootReducer,
        initialState,
        composeWithDevTools(applyMiddleware(...middlewares)),
    );
    return store;
}

export default configureStore();

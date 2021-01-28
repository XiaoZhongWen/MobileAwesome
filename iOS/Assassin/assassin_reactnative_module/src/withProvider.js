/*
 * @Author: your name
 * @Date: 2021-01-25 17:48:57
 * @LastEditTime: 2021-01-26 11:21:20
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/withProvider.js
 */

import React, {Component} from 'react';
import {Provider} from 'react-redux';
import store from './common/store';

export default function withProvider(WrappedComponent) {
    return class extends Component {
        render() {
            return (
                <Provider store={store}>
                    <WrappedComponent />
                </Provider>
            );
        }
    };
}

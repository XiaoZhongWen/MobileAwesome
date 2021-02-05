/*
 * @Author: your name
 * @Date: 2021-02-05 09:50:23
 * @LastEditTime: 2021-02-05 09:52:40
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/common/components/SeparatorLine.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';
import {COMMON_HEADER_SIZE, COMMOM_MARGIN} from '../constants';

export default class SeparatorLine extends Component {
    render() {
        return <View style={styles.line} />;
    }
}

const styles = StyleSheet.create({
    line: {
        height: 0.5,
        backgroundColor: '#DDDDDD',
        marginLeft: COMMON_HEADER_SIZE + 2 * COMMOM_MARGIN,
    },
});

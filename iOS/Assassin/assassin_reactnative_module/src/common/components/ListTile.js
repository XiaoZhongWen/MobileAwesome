/*
 * @Author: your name
 * @Date: 2021-01-28 16:47:11
 * @LastEditTime: 2021-01-28 17:00:10
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/common/components/ListTile.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';
import {COMMOM_MARGIN} from '../constants';

export default class ListTile extends Component {
    render() {
        const {title, icon} = this.props;
        return (
            <View style={styles.container}>
                <Text style={styles.title}> {title} </Text>
                {icon}
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        backgroundColor: 'white',
        marginTop: 5,
        paddingLeft: 5,
        paddingRight: 5,
        borderRadius: 5,
        paddingTop: COMMOM_MARGIN,
        paddingBottom: COMMOM_MARGIN,
    },
    title: {
        fontSize: 13,
    },
});

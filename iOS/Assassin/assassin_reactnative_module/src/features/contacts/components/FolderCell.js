/*
 * @Author: your name
 * @Date: 2021-01-27 17:39:53
 * @LastEditTime: 2021-01-28 13:46:47
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/contacts/components/FolderCell.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View, Image} from 'react-native';
import {COMMOM_MARGIN} from '../../../common/constants';

export default class FolderCell extends Component {
    render() {
        const {data, icon} = this.props;
        return (
            <View style={styles.container}>
                {icon}
                <Text style={styles.text}> {data.tag} </Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flexDirection: 'row',
        alignItems: 'center',
        padding: COMMOM_MARGIN,
        backgroundColor: '#eeeeee',
    },
    text: {
        marginLeft: COMMOM_MARGIN,
    },
});

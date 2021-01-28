/*
 * @Author: your name
 * @Date: 2021-01-28 16:11:21
 * @LastEditTime: 2021-01-28 16:45:49
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/common/components/BusinessCard.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View, Image} from 'react-native';
import ContactsCell from '../../features/contacts/components/ContactsCell';
import {COMMOM_MARGIN} from '../constants';

export default class BusinessCard extends Component {
    render() {
        const {contacts} = this.props;
        return (
            <View style={styles.container}>
                <ContactsCell
                    data={contacts}
                    size={50.0}
                    titleStyle={{fontSize: 16}}
                    subtitleStyle={{fontSize: 13}}
                />
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        backgroundColor: 'white',
        height: 100,
        justifyContent: 'center',
        borderRadius: 5,
        shadowColor: 'gray',
        shadowOffset: {h: 5, w: 5},
        shadowOpacity: 0.8,
    },
});

/*
 * @Author: your name
 * @Date: 2021-01-28 11:53:43
 * @LastEditTime: 2021-01-28 12:22:49
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/contacts/components/SearchBar.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View, TextInput} from 'react-native';
import {Colors} from 'react-native/Libraries/NewAppScreen';
import {COMMOM_MARGIN, COMMON_THEME_COLOR} from '../../../common/constants';

export default class SearchBar extends Component {
    render() {
        return (
            <View style={styles.container}>
                <TextInput
                    style={styles.textInput}
                    placeholder={'搜索'}
                    selectionColor={COMMON_THEME_COLOR}
                />
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        marginLeft: COMMOM_MARGIN,
        marginRight: COMMOM_MARGIN,
        marginTop: COMMOM_MARGIN,
        borderRadius: 5,
        backgroundColor: '#DDDDDD',
    },
    textInput: {
        marginLeft: COMMOM_MARGIN,
        marginRight: COMMOM_MARGIN,
        marginTop: 5,
        marginBottom: 5,
    },
});

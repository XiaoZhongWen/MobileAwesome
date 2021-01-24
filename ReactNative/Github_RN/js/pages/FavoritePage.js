/*
 * @Author: your name
 * @Date: 2021-01-19 21:56:08
 * @LastEditTime: 2021-01-19 21:56:57
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /Github_RN/js/pages/FavoritePage.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';

export default class FavoritePage extends Component {
    render() {
        return (
            <View style={styles.container}>
                <Text> FavoritePage </Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
});

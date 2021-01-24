/*
 * @Author: your name
 * @Date: 2021-01-19 21:54:59
 * @LastEditTime: 2021-01-19 21:55:30
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /Github_RN/js/pages/PopularPage.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';

export default class PopularPage extends Component {
    render() {
        return (
            <View style={styles.container}>
                <Text> PopularPage </Text>
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

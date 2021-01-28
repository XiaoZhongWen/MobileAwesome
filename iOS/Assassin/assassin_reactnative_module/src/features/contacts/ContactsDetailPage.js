/*
 * @Author: your name
 * @Date: 2021-01-28 15:50:17
 * @LastEditTime: 2021-01-28 17:35:54
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/contacts/ContactsDetailPage.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View, Button, TouchableOpacity} from 'react-native';
import Ionicons from 'react-native-vector-icons/Ionicons';
import {KEY_CONTACTS} from '../contacts/redux/constants';
import BusinessCard from '../../common/components/BusinessCard';
import {COMMOM_MARGIN, COMMON_THEME_COLOR} from '../../common/constants';
import ListTile from '../../common/components/ListTile';

export default class ContactsDetailPage extends Component {
    static navigationOptions = {
        title: '详细资料',
    };

    constructor(props) {
        super(props);
    }

    render() {
        const {navigation} = this.props;
        const contacts = navigation.getParam(KEY_CONTACTS, {});
        return (
            <View style={styles.container}>
                <View>
                    <BusinessCard contacts={contacts} />
                    <ListTile
                        title={'个人空间'}
                        icon={
                            <Ionicons
                                name="chevron-forward-outline"
                                color={'lightgray'}
                            />
                        }
                    />
                </View>
                <View style={styles.bottom_container}>
                    <TouchableOpacity style={styles.btn_container}>
                        <Text style={styles.send_msg}>{'发消息'}</Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.btn_container}>
                        <Text style={styles.call}>{'电话'}</Text>
                    </TouchableOpacity>
                    <TouchableOpacity style={styles.btn_container_border}>
                        <Text style={styles.delete}>{'删除好友'}</Text>
                    </TouchableOpacity>
                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        margin: COMMOM_MARGIN,
        justifyContent: 'space-between',
    },
    bottom_container: {
        flexDirection: 'row',
        justifyContent: 'space-between',
    },
    btn_container: {
        backgroundColor: COMMON_THEME_COLOR,
        paddingTop: COMMOM_MARGIN,
        paddingBottom: COMMOM_MARGIN,
        paddingLeft: 20,
        paddingRight: 20,
        borderRadius: 5,
        width: 110,
        alignItems: 'center',
    },
    btn_container_border: {
        backgroundColor: 'white',
        paddingTop: COMMOM_MARGIN,
        paddingBottom: COMMOM_MARGIN,
        paddingLeft: 20,
        paddingRight: 20,
        borderRadius: 5,
        borderWidth: 1,
        borderColor: COMMON_THEME_COLOR,
        width: 110,
        alignItems: 'center',
    },
    send_msg: {
        fontSize: 15,
        color: 'white',
    },
    call: {
        fontSize: 15,
        color: 'white',
    },
    delete: {
        fontSize: 15,
        color: COMMON_THEME_COLOR,
    },
});

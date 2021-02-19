/*
 * @Author: your name
 * @Date: 2021-02-05 15:00:11
 * @LastEditTime: 2021-02-07 10:54:26
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/message/ChatPage.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';
import {bindActionCreators} from 'redux';
import {connect} from 'react-redux';
import {fetchLastestConversation} from './redux/fetchConversationList';
import {KEY_CHAT} from './redux/constants';

class ChatPage extends Component {
    static navigationOptions = ({navigation}) => {
        const {nickname} = navigation.getParam(KEY_CHAT, '');
        return {
            title: nickname,
        };
    };

    constructor(props) {
        super(props);
        const {fetchLastestConversation} = props;
        const {navigation} = props;
        const {userId} = navigation.getParam(KEY_CHAT, '');
        fetchLastestConversation(userId);
    }

    render() {
        const {messages} = this.props;
        return (
            <View>
                <Text> textInComponent </Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({});

const mapStateToProps = (state) => ({
    messages: state.messages,
});

const mapDispatchToProps = (dispatch) =>
    bindActionCreators({fetchLastestConversation}, dispatch);

export default connect(mapStateToProps, mapDispatchToProps)(ChatPage);

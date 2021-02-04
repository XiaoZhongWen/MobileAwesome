/*
 * @Author: your name
 * @Date: 2021-01-25 11:04:45
 * @LastEditTime: 2021-02-04 16:44:55
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/message/MessagePage.js
 */

import React, {Component} from 'react';
import {Text, StyleSheet, View} from 'react-native';
import {createAppContainer} from 'react-navigation';
import {createStackNavigator} from 'react-navigation-stack';
import {bindActionCreators} from 'redux';
import {connect} from 'react-redux';
import {fetchMessageList} from './redux/actions';
import Icon from 'react-native-vector-icons/Ionicons';
import {
    COMMOM_NAV_BAR_ICON_SIZE,
    COMMOM_MARGIN,
    COMMON_ROUTENAME_CONTACTS,
} from '../../common/constants';
import withProvider from '../../withProvider';
import navigationManager from '../../common/navigator/NavigationManager';

import NBContainer from '../../nativebase/NBContainer';

class MessagePage extends Component {
    static navigationOptions = {
        title: '消息',
        headerLeft: () => (
            <Icon
                style={styles.left}
                name={'person-add-outline'}
                size={COMMOM_NAV_BAR_ICON_SIZE}
                color="white"
                onPress={() => {
                    navigationManager.push(COMMON_ROUTENAME_CONTACTS);
                }}
            />
        ),
    };

    constructor(props) {
        super(props);
        navigationManager.navigation = this.props.navigation;
        const {fetchMessageList} = this.props;
        fetchMessageList();
    }

    render() {
        const {messages} = this.props;
        const {messageList, fetchMessageListError} = messages;
        console.log(messageList);
        return (
            <View style={styles.container}>
                {/* <View style={styles.nb_container}>
                    <NBContainer title={'Anatomy'} onClick={this.onNBClick} />
                    <NBContainer title={'Accordion'} onClick={this.onNBClick} />
                </View> */}
            </View>
        );
    }

    // onNBClick(routeName) {
    //     navigationManager.push(routeName);
    // }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    left: {
        marginLeft: COMMOM_MARGIN,
    },
    nb_container: {
        flexDirection: 'row',
        padding: COMMOM_MARGIN,
        justifyContent: 'space-between',
        alignItems: 'center',
    },
});

const mapStateToProps = (state) => ({
    messages: state.messages,
});

const mapDispatchToProps = (dispatch) =>
    bindActionCreators({fetchMessageList}, dispatch);

export default connect(mapStateToProps, mapDispatchToProps)(MessagePage);

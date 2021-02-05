/*
 * @Author: your name
 * @Date: 2021-01-26 12:02:29
 * @LastEditTime: 2021-02-05 09:53:34
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/features/contacts/ContactsPage.js
 */

import React, {Component} from 'react';
import {
    Text,
    StyleSheet,
    View,
    FlatList,
    SectionList,
    Image,
    TouchableOpacity,
    ActivityIndicator,
    RefreshControl,
} from 'react-native';
import {bindActionCreators} from 'redux';
import {connect} from 'react-redux';
import {fetchContactsList} from '../contacts/redux/actions';
import FolderCell from './components/FolderCell';
import ContactsCell from './components/ContactsCell';
import {
    COMMOM_MARGIN,
    COMMON_HEADER_SIZE,
    COMMON_ROUTENAME_CONTACTS_DETAIL,
    COMMON_THEME_COLOR,
} from '../../common/constants';
import {
    CONSTANTS_PUBLIC_ACCOUNT,
    CONSTANTS_CONTACTS,
    KEY_CONTACTS,
} from '../contacts/redux/constants';
import SearchBar from './components/SearchBar';
import navigationManager from '../../common/navigator/NavigationManager';
import SeparatorLine from '../../common/components/SeparatorLine';

class ContactsPage extends Component {
    static navigationOptions = {
        title: '联系人',
    };

    constructor(props) {
        super(props);
        this.state = {
            isFolder: true,
        };
        const {fetchContactsList} = this.props;
        fetchContactsList();
    }

    render() {
        const {contacts} = this.props;
        const {
            contactsList,
            fetchContactsListPending,
            fetchContactsListError,
        } = contacts;
        let datasource = this._datasource(contactsList);

        return (
            <View style={styles.container}>
                <SectionList
                    sections={datasource}
                    keyExtractor={(item, index) => {
                        return index.toString();
                    }}
                    ListHeaderComponent={SearchBar}
                    refreshControl={
                        <RefreshControl
                            title={'loading'}
                            tintColor={COMMON_THEME_COLOR}
                            refreshing={fetchContactsListPending}
                            onRefresh={() => this._onRefresh()}
                        />
                    }
                    ItemSeparatorComponent={(item) =>
                        !this.state.isFolder &&
                        item.section.type == CONSTANTS_CONTACTS ? (
                            <SeparatorLine />
                        ) : null
                    }
                    renderSectionHeader={(info) => {
                        const type = info.section.type;
                        return (
                            <View>
                                {type == CONSTANTS_CONTACTS ? (
                                    <View style={styles.contacts_separator}>
                                        <Text style={styles.contacts_text}>
                                            {'联系人'}
                                        </Text>
                                    </View>
                                ) : null}
                                <TouchableOpacity
                                    onPress={() => this._onSectionClick(type)}>
                                    <FolderCell
                                        data={info.section}
                                        icon={this._icon(type)}
                                    />
                                </TouchableOpacity>
                            </View>
                        );
                    }}
                    renderItem={(item, index, section, separators) => {
                        return !this.state.isFolder &&
                            item.section.type == CONSTANTS_CONTACTS ? (
                            <TouchableOpacity
                                onPress={() => {
                                    navigationManager.push(
                                        COMMON_ROUTENAME_CONTACTS_DETAIL,
                                        {
                                            KEY_CONTACTS: item.item,
                                        },
                                    );
                                }}>
                                <ContactsCell data={item.item} />
                            </TouchableOpacity>
                        ) : null;
                    }}
                />
            </View>
        );
    }

    _onRefresh() {
        const {fetchContactsList} = this.props;
        fetchContactsList();
    }

    _datasource(contactsList) {
        const datasource =
            contactsList?.map(function name(cur, index) {
                return {
                    type: cur.type,
                    tag: cur.tag,
                    data: cur.items,
                };
            }) ?? [];
        return datasource;
    }

    _icon(type) {
        let icon = null;
        switch (type) {
            case CONSTANTS_PUBLIC_ACCOUNT:
                // 公众号
                icon = (
                    <Image
                        source={require('../../../img/public_account.png')}
                    />
                );
                break;
            case CONSTANTS_CONTACTS:
                // 联系人
                const path = this.state.isFolder
                    ? require('../../../img/contact_fold.png')
                    : require('../../../img/contact_unfold.png');
                icon = (
                    <Image
                        source={path}
                        style={{width: null, height: null}}
                        width={15}
                        height={15}
                    />
                );
            default:
                break;
        }
        return icon;
    }

    _onSectionClick(type) {
        if (type == CONSTANTS_CONTACTS) {
            this.setState({
                isFolder: !this.state.isFolder,
            });
        }
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
    },
    center: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    contacts_separator: {
        backgroundColor: '#DDDDDD',
        paddingLeft: COMMOM_MARGIN,
        paddingTop: 3,
        paddingBottom: 3,
    },
    contacts_text: {
        color: 'gray',
    },
});

const mapStateToProps = (state) => ({
    contacts: state.contacts,
});

const mapDispatchToProps = (dispatch) =>
    bindActionCreators({fetchContactsList}, dispatch);

export default connect(mapStateToProps, mapDispatchToProps)(ContactsPage);

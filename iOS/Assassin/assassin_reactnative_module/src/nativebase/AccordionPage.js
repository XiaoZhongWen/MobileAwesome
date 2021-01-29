/*
 * @Author: your name
 * @Date: 2021-01-29 11:04:18
 * @LastEditTime: 2021-01-29 12:34:20
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /assassin_reactnative_module/src/nativebase/AccordionPage.js
 */
import React, {Component} from 'react';
import {Container, Header, Content, Accordion} from 'native-base';
// const dataArray = [
//     {title: 'First Element', content: 'Lorem ipsum dolor sit amet'},
//     {title: 'Second Element', content: 'Lorem ipsum dolor sit amet'},
//     {title: 'Third Element', content: 'Lorem ipsum dolor sit amet'},
// ];
const dataMenus = [
    {title: 'Credit Card', content: 'creditCardContent'},
    {
        title: 'Bank Account (for ACH payments)',
        content: 'Lorem ipsum dolor sit amet',
    },
    {title: 'Recurring Payment', content: 'Lorem ipsum dolor sit amet'},
];
export default class AccordionExample extends Component {
    render() {
        return (
            <Container>
                <Header />
                <Content padder>
                    <Accordion dataArray={dataMenus} expanded={0} />
                </Content>
            </Container>
        );
    }
}

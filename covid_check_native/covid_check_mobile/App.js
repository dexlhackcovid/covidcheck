import React from 'react';
import { StatusBar } from 'react-native';

import Routes from './src/Routes';
import Colors from './src/components/Colors'

export default function App() {
  return (
    <>
      <StatusBar barStyle='light-content' backgroundColor={Colors.background}/>
      <Routes />      
    </>
  );
}

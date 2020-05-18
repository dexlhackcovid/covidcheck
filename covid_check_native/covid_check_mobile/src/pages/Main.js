import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';
import MedicalIcon from '../components/MedicalIcon';

import Colors from '../components/Colors';

function Main({ navigation }) {
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Bem-vindo ao Covid Check!</Text>
      <MedicalIcon style={styles.icon}/>
      <TouchableOpacity 
        style={styles.button}
        onPress={() => {navigation.navigate('Screening')}}
      >
        <Text style={styles.buttonText}>Começar</Text>  
      </TouchableOpacity>
    </View>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
  },
  title: {
    fontSize: 26,
    marginTop: 60,
  },
  icon: {
    marginTop: 50,
  },
  button: {
    height: 42,
    width: 200,
    backgroundColor: Colors.primary,
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 2,
    position: 'absolute',
    bottom: 60,
  },
  buttonText: {
    color: '#FFF',
    fontSize: 20
  },
});

export default Main;
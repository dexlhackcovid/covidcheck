import React from 'react';
import { StyleSheet, View, Text, ScrollView, TouchableOpacity } from 'react-native';

import HospitalMock from '../mocks/HospitalMock';
import Colors from '../components/Colors';

function HospitalList({ navigation }) {
  return (
    <ScrollView>
      <View style={styles.container}>
        <Text style={styles.title}>Você foi indicado com 60% na classificação de risco moderado.</Text>
        {HospitalMock.map(hospital => (
          <View key={hospital.name} style={styles.card}>
            <Text>{hospital.name}</Text>
            <Text style={styles.addressText}>{hospital.address}</Text>
            <Text>{`Tempo de espera estimado para sua classificação: ${hospital.time} minutos`}</Text>
          </View>
        ))}
        <TouchableOpacity 
          style={styles.button}
          onPress={() => {navigation.navigate('Maps')}}
        >
          <Text style={styles.buttonText}>Prosseguir</Text>  
        </TouchableOpacity>
      </View>
    </ScrollView>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: "center",
    paddingTop: 20,
    paddingLeft: 20,
    paddingRight: 20,
  },
  card: {
    borderColor: '#DDD',
    borderWidth: 1,
    marginTop: 10,
    width: '100%',
    justifyContent: 'center',
    padding: 10,
    borderRadius: 5,
  },
  title: {
    fontSize: 15.5,
  },
  addressText: {
    fontSize: 12,
    marginBottom: 10,
  },
  button: {
    height: 42,
    width: 200,
    backgroundColor: Colors.primary,
    justifyContent: 'center',
    alignItems: 'center',
    borderRadius: 2,
    marginTop: 30,
    marginBottom: 30,
  },
  buttonText: {
    color: '#FFF',
    fontSize: 20
  },
});

export default HospitalList;
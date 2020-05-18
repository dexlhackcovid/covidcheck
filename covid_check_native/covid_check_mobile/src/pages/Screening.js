import React from 'react';
import { StyleSheet, View, Text, TextInput, CheckBox, TouchableOpacity, ScrollView } from 'react-native';

import Colors from '../components/Colors';

function Screening({ navigation }) {
  return (
    <ScrollView>
      <View style={styles.container}>
        <Text style={styles.label}>Idade</Text>
        <TextInput
          style={styles.input}
          placeholder="Qual é a sua idade?"
          placeholderTextColor="#999"
        />
        <Text style={styles.label}>Temperatura</Text>
        <TextInput
          style={styles.input}
          placeholder="Temperatura medida por um termômetro"
          placeholderTextColor="#999"
        />
        <Text style={styles.label}>Pulsação cardiaca</Text>
        <TextInput
          style={styles.input}
          placeholder="Pulsação cardiaca"
          placeholderTextColor="#999"
        />
        <Text style={styles.label}>Marque caso possua alguma das condições a seguir</Text>
        <View style={{ flexDirection: 'row' }}>
          <CheckBox/>
          <Text style={{marginTop: 7}}>Hipertensão</Text>
        </View>
        <View style={{ flexDirection: 'row' }}>
          <CheckBox/>
          <Text style={{marginTop: 7}}>Diabetes</Text>
        </View>
        <View style={{ flexDirection: 'row' }}>
          <CheckBox/>
          <Text style={{marginTop: 7}}>Asma</Text>
        </View>
        <View style={{ flexDirection: 'row' }}>
          <CheckBox/>
          <Text style={{marginTop: 7}}>Oncologia</Text>
        </View>
        <Text style={styles.label}>Marque nas caixas a seguir quais dos sintomas você possui</Text>
        <View style={{ flexDirection: 'row' }}>
          <CheckBox/>
          <Text style={{marginTop: 7}}>Tosse</Text>
        </View>
        <View style={{ flexDirection: 'row' }}>
          <CheckBox/>
          <Text style={{marginTop: 7}}>Falta de ar</Text>
        </View>
        <View style={{ flexDirection: 'row' }}>
          <CheckBox/>
          <Text style={{marginTop: 7}}>Dor de cabeça</Text>
        </View>
        <View style={{ flexDirection: 'row' }}>
          <CheckBox/>
          <Text style={{marginTop: 7}}>Corisa</Text>
        </View>
        <View style={{ alignItems: 'center' }}>
          <TouchableOpacity 
            style={styles.button}
            onPress={() => {navigation.navigate('HospitalList')}}
          >
            <Text style={styles.buttonText}>Prosseguir</Text>  
          </TouchableOpacity>
        </View>
      </View>
    </ScrollView>
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    marginLeft: 30,
    marginRight: 30,
  },
  label: {
    fontSize: 17,
    fontWeight: 'bold',
    color: '#444',
    marginBottom: 8,
    marginTop: 30,
  },
  input: {
    borderWidth: 1,
    borderColor: '#ddd',
    paddingHorizontal: 20,
    fontSize: 16,
    color: '#444',
    height: 44,
    borderRadius: 2
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
    fontSize: 20,
  },
});

export default Screening;

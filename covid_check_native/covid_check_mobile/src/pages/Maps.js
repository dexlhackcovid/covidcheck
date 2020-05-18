import React, { useEffect, useState } from 'react';
import { StyleSheet } from 'react-native';
import MapView, { Marker } from 'react-native-maps';
import { requestPermissionsAsync, getCurrentPositionAsync } from 'expo-location';

import HospitalMock from '../mocks/HospitalMock';

function Maps() {
  const [currentRegion, setCurrentRegion] = useState(null);

  useEffect(() => {
    async function loadMyPosition() {
      const { granted } = await requestPermissionsAsync();

      if (granted){
        const { coords } = await getCurrentPositionAsync({
          enableHighAccuracy: true,
        });

        const { latitude, longitude } = coords;

        setCurrentRegion({
          latitude,
          longitude,
          latitudeDelta: 0.04, 
          longitudeDelta: 0.04,
        });
      }
    }

    function loadInitialPosition() {
      let latitude = 0;
      let longitude = 0;

      HospitalMock.forEach(hospital => {
        latitude += hospital.latitude;
        longitude += hospital.longitude;
      });

      latitude /= HospitalMock.length;
      longitude /= HospitalMock.length;

      setCurrentRegion({
        latitude,
        longitude,
        latitudeDelta: 0.30, 
        longitudeDelta: 0.30,
      });
    }

    loadInitialPosition();
  }, []);

  function handleRegionChanged(region) {
    setCurrentRegion(region);
  }

  if (!currentRegion) {
    return null;
  }

  // TODO: Add interative loop.
  return (
    <MapView 
      onRegionChangeComplete={handleRegionChanged} 
      initialRegion={currentRegion} 
      style={styles.map}
    >
      <Marker coordinate={{ longitude: HospitalMock[0].longitude, latitude: HospitalMock[0].latitude, }} />
      <Marker coordinate={{ longitude: HospitalMock[1].longitude, latitude: HospitalMock[1].latitude, }} />
      <Marker coordinate={{ longitude: HospitalMock[2].longitude, latitude: HospitalMock[2].latitude, }} />
      <Marker coordinate={{ longitude: HospitalMock[3].longitude, latitude: HospitalMock[3].latitude, }} />
      <Marker coordinate={{ longitude: HospitalMock[4].longitude, latitude: HospitalMock[4].latitude, }} />
      <Marker coordinate={{ longitude: HospitalMock[5].longitude, latitude: HospitalMock[5].latitude, }} />
      <Marker coordinate={{ longitude: HospitalMock[6].longitude, latitude: HospitalMock[6].latitude, }} />
      <Marker coordinate={{ longitude: HospitalMock[7].longitude, latitude: HospitalMock[7].latitude, }} />
      <Marker coordinate={{ longitude: HospitalMock[8].longitude, latitude: HospitalMock[8].latitude, }} />
      <Marker coordinate={{ longitude: HospitalMock[9].longitude, latitude: HospitalMock[9].latitude, }} />
      <Marker coordinate={{ longitude: HospitalMock[10].longitude, latitude: HospitalMock[10].latitude, }} />
      <Marker coordinate={{ longitude: HospitalMock[11].longitude, latitude: HospitalMock[11].latitude, }} />
    </MapView>
  )
}

const styles = StyleSheet.create({
  map: {
    flex: 1,
  },
});

export default Maps;
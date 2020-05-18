import { createAppContainer } from 'react-navigation';
import { createStackNavigator } from 'react-navigation-stack';

import Colors from './components/Colors';
import Main from './pages/Main';
import Screening from './pages/Screening';
import Maps from './pages/Maps';
import HospitalList from './pages/HospitalList';

const Routes = createAppContainer(
  createStackNavigator({
    Main: {
      screen: Main,
      navigationOptions: {
        title: 'Covid Check'
      }, 
    },
    Screening: {
      screen: Screening,
      navigationOptions: {
        title: 'Triagem'
      },
    },
    Maps: {
      screen: Maps,
      navigationOptions: {
        title: 'Localização'
      },
    },
    HospitalList: {
      screen: HospitalList,
      navigationOptions: {
        title: 'Unidades de emergência',
      },
    },
  }, {
    defaultNavigationOptions: {
      headerTintColor: '#FFF',
      headerBackTitleVisible: false,
      headerStyle: {
        backgroundColor: Colors.primary, 
      }
    },
  })
);

export default Routes;
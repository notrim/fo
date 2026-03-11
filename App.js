import React, { useState } from 'react';
import { View, Text, StyleSheet, ScrollView } from 'react-native';
import { Calendar, LocaleConfig } from 'react-native-calendars';
import { SafeAreaView } from 'react-native-safe-area-context';

// 配置中文语言
LocaleConfig.locales['zh'] = {
  monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
  monthNamesShort: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
  dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
  dayNamesShort: ['日', '一', '二', '三', '四', '五', '六'],
  today: '今天'
};
LocaleConfig.defaultLocale = 'zh';

// 佛教主要节日数据
const buddhistHolidays = [
  { date: '2026-05-21', title: '佛诞节', description: '释迦牟尼佛诞辰' },
  { date: '2026-04-08', title: '浴佛节', description: '庆祝佛陀诞辰' },
  { date: '2026-07-15', title: '盂兰盆节', description: '佛教超度亡魂的节日' },
  { date: '2026-02-28', title: '涅槃节', description: '纪念佛陀涅槃' },
  { date: '2026-01-15', title: '腊八节', description: '纪念佛陀成道' },
  { date: '2026-12-08', title: '成道节', description: '佛陀成道日' },
  { date: '2026-03-15', title: '观音圣诞', description: '观世音菩萨诞辰' },
  { date: '2026-09-19', title: '观音成道', description: '观世音菩萨成道日' },
  { date: '2026-11-19', title: '弥陀圣诞', description: '阿弥陀佛诞辰' },
  { date: '2026-07-30', title: '地藏圣诞', description: '地藏王菩萨诞辰' }
];

// 生成标记对象
const getMarkedDates = () => {
  const marked = {};
  buddhistHolidays.forEach(holiday => {
    marked[holiday.date] = {
      marked: true,
      dotColor: '#FF6B6B',
      selected: true,
      selectedColor: '#4ECDC4'
    };
  });
  return marked;
};

export default function App() {
  const [selectedDate, setSelectedDate] = useState('');
  const [selectedHoliday, setSelectedHoliday] = useState(null);

  const handleDayPress = (day) => {
    setSelectedDate(day.dateString);
    const holiday = buddhistHolidays.find(h => h.date === day.dateString);
    setSelectedHoliday(holiday);
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>佛历</Text>
        <Text style={styles.subtitle}>佛教主要节日日历</Text>
      </View>
      
      <Calendar
        current={new Date().toISOString().split('T')[0]}
        markedDates={getMarkedDates()}
        onDayPress={handleDayPress}
        theme={{
          todayTextColor: '#4ECDC4',
          selectedDayBackgroundColor: '#4ECDC4',
          arrowColor: '#4ECDC4',
          monthTextColor: '#292F36',
          dayTextColor: '#292F36',
          textDisabledColor: '#BDC3C7'
        }}
      />
      
      <ScrollView style={styles.holidayList}>
        <Text style={styles.sectionTitle}>佛教主要节日</Text>
        {buddhistHolidays.map((holiday, index) => (
          <View key={index} style={styles.holidayItem}>
            <Text style={styles.holidayDate}>{holiday.date}</Text>
            <View style={styles.holidayInfo}>
              <Text style={styles.holidayTitle}>{holiday.title}</Text>
              <Text style={styles.holidayDescription}>{holiday.description}</Text>
            </View>
          </View>
        ))}
      </ScrollView>
      
      {selectedHoliday && (
        <View style={styles.selectedHoliday}>
          <Text style={styles.selectedTitle}>所选日期: {selectedDate}</Text>
          <Text style={styles.selectedHolidayTitle}>{selectedHoliday.title}</Text>
          <Text style={styles.selectedHolidayDescription}>{selectedHoliday.description}</Text>
        </View>
      )}
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F7F9FC'
  },
  header: {
    padding: 20,
    alignItems: 'center',
    backgroundColor: '#4ECDC4'
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#FFFFFF',
    marginBottom: 5
  },
  subtitle: {
    fontSize: 16,
    color: '#FFFFFF'
  },
  holidayList: {
    flex: 1,
    padding: 20
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 15,
    color: '#292F36'
  },
  holidayItem: {
    flexDirection: 'row',
    padding: 15,
    backgroundColor: '#FFFFFF',
    borderRadius: 10,
    marginBottom: 10,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2
    },
    shadowOpacity: 0.1,
    shadowRadius: 3.84,
    elevation: 5
  },
  holidayDate: {
    width: 80,
    fontSize: 14,
    color: '#7F8C8D',
    textAlign: 'center'
  },
  holidayInfo: {
    flex: 1,
    marginLeft: 15
  },
  holidayTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#292F36',
    marginBottom: 5
  },
  holidayDescription: {
    fontSize: 14,
    color: '#7F8C8D'
  },
  selectedHoliday: {
    position: 'absolute',
    bottom: 20,
    left: 20,
    right: 20,
    backgroundColor: '#FFFFFF',
    padding: 20,
    borderRadius: 10,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2
    },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5
  },
  selectedTitle: {
    fontSize: 14,
    color: '#7F8C8D',
    marginBottom: 5
  },
  selectedHolidayTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#292F36',
    marginBottom: 5
  },
  selectedHolidayDescription: {
    fontSize: 14,
    color: '#7F8C8D'
  }
});
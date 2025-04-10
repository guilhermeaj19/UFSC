import unittest
import datetime

class TesteExercicio1(unittest.TestCase):

    def test_cria_date(self):
        # Fixture Setup
        # Exercise SUT
        date_ = datetime.date(2020, 10, 31)
        # Result Verification
        self.assertEqual(2020, date_.year)
        self.assertEqual(10, date_.month)
        self.assertEqual(31, date_.day)
        # Fixture Teardown

    def test_cria_time(self):
        # Fixture Setup
        # Exercise SUT
        date_ = datetime.time(23,56,15,311)
        # Result Verification
        self.assertEqual(23, date_.hour)
        self.assertEqual(56, date_.minute)
        self.assertEqual(15, date_.second)
        self.assertEqual(311, date_.microsecond)
        # Fixture Teardown

    def test_cria_datetime(self):
        # Fixture Setup
        # Exercise SUT
        date_ = datetime.datetime(2023,7,17,4,56,32,3211)
        # Result Verification
        self.assertEqual(2023, date_.year)
        self.assertEqual(7, date_.month)
        self.assertEqual(17, date_.day)
        self.assertEqual(4, date_.hour)
        self.assertEqual(56, date_.minute)
        self.assertEqual(32, date_.second)
        self.assertEqual(3211, date_.microsecond)
        # Fixture Teardown

    def test_cria_date_dia_31_de_abril_invalido(self):
        # Fixture Setup
        # Exercise SUT
        with self.assertRaises(ValueError):
            data_invalida = datetime.date(2024, 4, 31)
        # Result Verification
        # Fixture Teardown

    def test_cria_date_dia_zero_invalido(self):
        # Fixture Setup
        # Exercise SUT
        with self.assertRaises(ValueError):
            data_invalida = datetime.date(2024, 4, 0)
        # Result Verification
        # Fixture Teardown

    def test_cria_date_mes_positivo_invalido(self):
        # Fixture Setup
        # Exercise SUT
        with self.assertRaises(ValueError):
            data_invalida = datetime.date(2024, 13, 1)
        # Result Verification
        # Fixture Teardown

    def test_cria_date_mes_zero_invalido(self):
        # Fixture Setup
        # Exercise SUT
        with self.assertRaises(ValueError):
            data_invalida = datetime.date(2024, 0, 1)
        # Result Verification
        # Fixture Teardown

    def test_cria_date_mes_negativo_invalido(self):
        # Fixture Setup
        # Exercise SUT
        with self.assertRaises(ValueError):
            data_invalida = datetime.date(2024, -3, 1)
        # Result Verification
        # Fixture Teardown

    def test_cria_date_ano_menor_que_minyear_invalido(self):
        # Fixture Setup
        # Exercise SUT
        with self.assertRaises(ValueError):
            data_invalida = datetime.date(0, 12, 1)
        # Result Verification
        # Fixture Teardown

    def test_cria_date_ano_maior_que_maxyear_invalido(self):
        # Fixture Setup
        # Exercise SUT
        with self.assertRaises(ValueError):
            data_invalida = datetime.date(10000, 12, 31)
        # Result Verification
        # Fixture Teardown

    def test_cria_time_invalido(self):
        # Fixture Setup
        # Exercise SUT
        with self.assertRaises(ValueError):
            data_invalida = datetime.time(25, 12, 31)
        # Result Verification
        # Fixture Teardown

    def test_toordinal(self):
        # Fixture Setup
        date_ = datetime.date(1, 12, 31)
        # Exercise SUT
        ordinal = date_.toordinal()
        # Result Verification
        self.assertEqual(365, ordinal)
        # Fixture Teardown
    
    def test_fromordinal(self):
        # Fixture Setup
        # Exercise SUT
        fromordinal = datetime.date.fromordinal(366)
        # Result Verification
        self.assertEqual(datetime.date(2,1,1), fromordinal)
        # Fixture Teardown

    def test_weekday_quarta_feira(self):
        # Fixture Setup
        date = datetime.date(2025, 3, 19)
        # Exercise SUT
        weekday = date.weekday()
        # Result Verification
        self.assertEqual(2,weekday)
        # Fixture Teardown

    def test_isoweekday_quarta_feira(self):
        # Fixture Setup
        date = datetime.date(2025, 3, 19)
        # Exercise SUT
        isoweekday_ = date.isoweekday()
        # Result Verification
        self.assertEqual(3,isoweekday_)
        # Fixture Teardown

    def test_soma_dias_data_timedelta_positivo(self):
        # Fixture Setup
        date_ = datetime.date(2025, 3, 25)
        timedelta_ = datetime.timedelta(days=7)
        # Exercise SUT
        new_date = date_ + timedelta_
        # Result Verification
        self.assertEqual(datetime.date(2025, 4, 1), new_date)
        # Fixture Teardown

    def test_soma_dias_data_timedelta_negativo(self):
        # Fixture Setup
        date_ = datetime.date(2025, 3, 25)
        timedelta_ = datetime.timedelta(days = -24)
        # Exercise SUT
        new_date = date_ + timedelta_
        # Result Verification
        self.assertEqual(datetime.date(2025, 3, 1), new_date)
        # Fixture Teardown

    def test_subtrai_dias_de_data(self):
        # Fixture Setup
        date_ = datetime.date(2025, 3, 25)
        timedelta_ = datetime.timedelta(days = 24)
        # Exercise SUT
        new_date = date_ - timedelta_
        # Result Verification
        self.assertEqual(datetime.date(2025, 3, 1), new_date)
        # Fixture Teardown

    def test_soma_horas_minutos_segundos_a_datetime(self):
        # Fixture Setup
        date_ = datetime.datetime(2025, 3, 25, 22, 32,32)
        timedelta_ = datetime.timedelta(hours = 5, minutes = 42, seconds=12)
        # Exercise SUT
        new_date = date_ + timedelta_
        # Result Verification
        self.assertEqual(datetime.datetime(2025, 3, 26, 4, 14,44), new_date)
        # Fixture Teardown

    def test_subtrai_horas_minutos_segundos_a_datetime(self):
        # Fixture Setup
        date_ = datetime.datetime(2025, 3, 12, 4, 32)
        timedelta_ = datetime.timedelta(hours = 5, minutes = 42, seconds = 10)
        # Exercise SUT
        new_date = date_ - timedelta_
        # Result Verification
        self.assertEqual(datetime.datetime(2025, 3, 11, 22, 49, 50), new_date)
        # Fixture Teardown

    def test_subtracao_entre_datas(self):
        # Fixture Setup
        date1 = datetime.date(2025, 3, 19)
        date2 = datetime.date(2025, 5, 23)
        # Exercise SUT
        resultado = date2 - date1
        # Result Verification
        self.assertEqual(65, resultado.days)
        # Fixture Teardown

    def test_datas_diferentes(self):
        # Fixture Setup
        date1 = datetime.date(2025, 3, 19)
        date2 = datetime.date(2025, 5, 23)
        # Exercise SUT
        isDiff = date1 != date2
        # Result Verification
        self.assertTrue(isDiff)
        # Fixture Teardown

    def test_datas_iguais(self):
        # Fixture Setup
        date1 = datetime.date(2025, 3, 19)
        date2 = datetime.date(2025, 3, 19)
        # Exercise SUT
        isEqual = date1 == date2
        # Result Verification
        self.assertTrue(isEqual)
        # Fixture Teardown

    def test_data1_menor_que_data2(self):
        # Fixture Setup
        date1 = datetime.date(2025, 3, 19)
        date2 = datetime.date(2025, 5, 28)
        # Exercise SUT
        isLess = date1 < date2
        # Result Verification
        self.assertTrue(isLess)
        # Fixture Teardown

    def test_data1_maior_que_data2(self):
        # Fixture Setup
        date1 = datetime.date(2025, 4, 9)
        date2 = datetime.date(2025, 3, 19)
        # Exercise SUT
        isGreater = date1 > date2
        # Result Verification
        self.assertTrue(isGreater)
        # Fixture Teardown

    def test_replace_day(self):
        # Fixture Setup
        date_ = datetime.date(2025, 3, 25)
        # Exercise SUT
        new_date = date_.replace(day = 31)
        # Result Verification
        self.assertEqual(datetime.date(2025, 3, 31), new_date)
        # Fixture Teardown

    def test_replace_month(self):
        # Fixture Setup
        date_ = datetime.date(2025, 3, 25)
        # Exercise SUT
        new_date = date_.replace(month= 9)
        # Result Verification
        self.assertEqual(datetime.date(2025, 9, 25), new_date)
        # Fixture Teardown

    def test_replace_year(self):
        # Fixture Setup
        date_ = datetime.date(2025, 3, 25)
        # Exercise SUT
        new_date = date_.replace(year = 1999)
        # Result Verification
        self.assertEqual(datetime.date(1999, 3, 25), new_date)

    def test_datetime_now(self):
        # Fixture Setup
        from time import sleep
        current_date1 = datetime.datetime.now()
        sleep(0.01)
        # Exercise SUT
        current_date2 = datetime.datetime.now()
        # Result Verification
        self.assertGreater(current_date2, current_date1)
        # Fixture Teardown

    def test_isoformat_data(self):
        # Fixture Setup
        date_ = datetime.date(2023,7,17)
        # Exercise SUT
        result = date_.isoformat()
        # Result Verification
        self.assertEqual("2023-07-17", result)
        # Fixture Teardown

    def test_isoformat_datetime_sem_microssegundos(self):
        # Fixture Setup
        date_ = datetime.datetime(2023,7,17,4,56,32)
        # Exercise SUT
        result = date_.isoformat()
        # Result Verification
        self.assertEqual("2023-07-17T04:56:32", result)
        # Fixture Teardown

    def test_isoformat_datetime_com_microssegundos(self):
        # Fixture Setup
        date_ = datetime.datetime(2023,7,17,4,56,32,3211)
        # Exercise SUT
        result = date_.isoformat()
        # Result Verification
        self.assertEqual("2023-07-17T04:56:32.003211", result)
        # Fixture Teardown
    
    def test_isoformat_hora_sem_microssegundos(self):
        # Fixture Setup
        date_ = datetime.time(4,56,32)
        # Exercise SUT
        result = date_.isoformat()
        # Result Verification
        self.assertEqual("04:56:32", result)
        # Fixture Teardown

    def test_isoformat_hora_com_microssegundos(self):
        # Fixture Setup
        date_ = datetime.time(12,56,32,542)
        # Exercise SUT
        result = date_.isoformat()
        # Result Verification
        self.assertEqual("12:56:32.000542", result)
        # Fixture Teardown

    def test_fromisoformat(self):
        # Fixture Setup
        # Exercise SUT
        result = datetime.datetime.fromisoformat("2023-07-17T04:56:32")
        # Result Verification
        self.assertEqual(datetime.datetime(2023,7,17,4,56,32),result)
        # Fixture Teardown
    
if __name__ == "__main__":

    unittest.main()
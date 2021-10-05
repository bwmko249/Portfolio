vehicle class
vehicle - class
brand name - variables(attributes)
behaviours of a vehicle(drive, horn, lights) - functions


class Vehicle:
    def __init__(self, brand, model, type):
        self.brand = brand
        self.model = model
        self.type = type
        self.tank_size = 14
        self.fuel_level = 0

    def fuel_full(self):
        self.fuel_level = self.tank_size
        print('your tank is now full')

    def drive(self):
        print(f'your {self.model} is now driving')

    def update_fuel_level(self, new_level):
        if new_level <= self.tank_size:
            self.fuel_level = new_level
            print(f'your fuel level is {new_level}')
        else:
            print('exceeded capacity')

    def get_fuel(self, amount):
        if self.fuel_level + amount <= self.tank_size:
            self.fuel_level += amount
            print(f'your fuel level is {self.fuel_level}')
        else:
            print('your tank is overfull')



car1 = Vehicle('toyota', 'camry', 'es350')
print(car1.brand)
car1.fuel_full()
car1.drive()
car1.repair = 'your car is now repaired'
print(car1.repair)
car1.drive()
car1.update_fuel_level(7)
car1.get_fuel(8)


class ElectricVehicle(Vehicle):
    def __init__(self, brand, model, type):
        super().__init__(brand, model, type)
        self.battery = Battery()
    #     self.battery = 85
    #     self.charge = 0
    #
    def charging(self):
        self.battery.charge_level = 100
        print('battery is fully charged')
    # def charging(self):
    #     self.charge = 100
    #     print('your battery is now full')

    def fuel_full(self):
        print('your car doesnt use fuel')



class Battery:
    def __init__(self,size = 85):
        self.size = size
        self.charge_level = 0

    def get_range(self):
        if self.size == 85:
            return 260
        elif self.size == 100:
            return 315

electric_car = ElectricVehicle('tesla', 'phantom', 'S')
electric_car.charging()
electric_car.fuel_full()
print(electric_car.model)
print(electric_car.battery.get_range())

electric1 = ElectricVehicle('toyota', 'prius', 'e')
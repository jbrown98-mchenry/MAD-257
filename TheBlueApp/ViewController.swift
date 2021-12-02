//
//  ViewController.swift
//  TheBlueApp
//
//  Created by Jim Brown on 11/29/21.
//

import CoreBluetooth
import UIKit


class ViewController: UIViewController {
    
    var centralManager: CBCentralManager!
    var peripherals = Array<CBPeripheral>()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bleScan: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
    }
}
    
extension ViewController: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if (central.state == CBManagerState.poweredOn){
            
            // Turned on
            self.centralManager?.scanForPeripherals(withServices: nil, options: nil)
            print("BLE powered on")
        }
        else {
            print("Something wrong with BLE")
            // Not on
        }
        }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripherals.append(peripheral)
        tableView.reloadData()
            
        // Print scan info in debugger area
        print(peripherals)
        
        // Write device name to text box on storyboard
        bleScan.text = peripheral.name
        
        }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        let peripheral = peripherals[indexPath.row]
        cell.textLabel?.text = peripheral.name
        
        return cell
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peripherals.count
        }
}
    


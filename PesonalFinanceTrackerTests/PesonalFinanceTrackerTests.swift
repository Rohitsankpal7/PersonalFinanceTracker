//
//  PesonalFinanceTrackerTests.swift
//  PesonalFinanceTrackerTests
//
//  Created by Rohit Sankpal on 25/05/25.
//

import CoreData
import XCTest
@testable import PesonalFinanceTracker

final class PesonalFinanceTrackerTests: XCTestCase {

    var viewModel: TransactionViewModel!
    var context: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        super.setUp()
        
        let container = NSPersistentContainer(name: "PesonalFinanceTracker")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]
        
        container.loadPersistentStores { (_, error) in
            XCTAssertNil(error)
        }
        
        context = container.viewContext
        viewModel = TransactionViewModel()
    }

    func testInvalidAmountShouldShowToast() {
        viewModel.amount = "-10"
        viewModel.category = "Food"
        viewModel.date = Date()
        viewModel.desc = "Test"
        
        viewModel.addTransaction(context)
        
        XCTAssertTrue(viewModel.showToast)
        XCTAssertEqual(viewModel.toastMessage, "Invalid input. Please check amount.")
    }
    
    func testMissingCategory_ShouldShowToast() {
        viewModel.amount = "100"
        viewModel.desc = "Bus ticket"
        viewModel.category = ""  // Missing
        viewModel.type = "Expense"

        viewModel.addTransaction(context)

        XCTAssertTrue(viewModel.showToast)
        XCTAssertEqual(viewModel.toastMessage, "Please select category.")
    }
    
    func testValidTransaction_ShouldShow_Success_Toast() {
        viewModel.amount = "100"
        viewModel.desc = "Bus ticket"
        viewModel.category = "Transport"
        viewModel.type = "Expense"
        
        viewModel.addTransaction(context)
        
        XCTAssertTrue(viewModel.showToast)
        XCTAssertEqual(viewModel.toastMessage, "Transaction added successfully!")
        
        let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
        let results = try! context.fetch(fetchRequest)
        XCTAssertEqual(results.count, 1)
        XCTAssert(results[0].amount == 100)
        XCTAssert(results[0].category == "Transport")
    }
    
    func testClearInputs_ShouldResetFields() {
        viewModel.amount = "99"
        viewModel.desc = "Something"
        viewModel.category = "Other"
        viewModel.type = "Income"
        viewModel.date = Date(timeIntervalSince1970: 0)
        
        viewModel.clearInputs()
        
        XCTAssertEqual(viewModel.amount, "")
        XCTAssertEqual(viewModel.desc, "")
    }
    
    override func tearDown() {
        viewModel = nil
        context = nil
        super.tearDown()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

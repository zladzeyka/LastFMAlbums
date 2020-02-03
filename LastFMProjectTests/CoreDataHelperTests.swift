//
//  CoreDataHelperTests.swift
//  LastFMProject
//
//  Created by Nadzeya Karaban on 21.11.19.
//  Copyright © 2019 Nadzeya Karaban. All rights reserved.
//

import XCTest
import CoreData
@testable import LastFMProject

class CoreDataHelperTests: XCTestCase {
    /*creating a CoreDataManager object, we will use this object to test operations like insert, update & delete*/
    var coreDataManager: CoreDataHelper!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        coreDataManager = CoreDataHelper.shared
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: CoreDataHelper test cases
    
    /*This test case test for the proper initialization of CoreDataManager class :)*/
      func test_init_coreDataHelper(){
        
        let instance = CoreDataHelper.shared
        /*Asserts that an expression is not nil.
         Generates a failure when expression == nil.*/
        XCTAssertNotNil( instance )
      }
    
      func test_fetchSavedAlbums() {
        let results = coreDataManager.fetchSavedAlbums()
        XCTAssertEqual(results.count, 1)
      }
    
    func test_saveAlbum() {
        let savedAlbums = coreDataManager.fetchSavedAlbums()
        let albumToSave = savedAlbums[0]
        let numberOfItems = savedAlbums.count
        coreDataManager.saveAlbum(album: albumToSave.name!, artist: albumToSave.artist!)
             
        XCTAssertEqual(coreDataManager.fetchSavedAlbums().count, numberOfItems)
    }
    
    func test_deleteAlbum() {
        let savedAlbums = coreDataManager.fetchSavedAlbums()
        let albumToDelete = savedAlbums[0]
        let numberOfItems = savedAlbums.count

        coreDataManager.deleteAlbum(album: albumToDelete.name!, artist: albumToDelete.artist!)
        
        XCTAssertEqual(coreDataManager.fetchSavedAlbums().count, numberOfItems-1)
    }
    
    func test_wasSaved() {
        let savedAlbums = coreDataManager.fetchSavedAlbums()
        let albumToCheck = savedAlbums[0]
        let wasSave = coreDataManager.wasSaved(album: albumToCheck.name!, artist: albumToCheck.artist!)
        XCTAssertEqual(wasSave, true)
    }

}

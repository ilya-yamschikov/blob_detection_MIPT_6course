function test_suite = test_blob_detection
    initTestSuite;
    
function test_one_blob
    IMG_SIZE = 128;
    BLOB_SIZE = 10;
    img = generate_blob([IMG_SIZE/2 IMG_SIZE/2], BLOB_SIZE, IMG_SIZE);
    [centers, radiuses] = detect_blobs(img, (BLOB_SIZE-2):0.25:(BLOB_SIZE+2));
    assertEqual(length(centers), 1);
    assertElementsAlmostEqual(centers{1}, [IMG_SIZE/2 IMG_SIZE/2], 'absolute', 1.5, 'One blob: wrong blob center');
    assertElementsAlmostEqual(radiuses{1}, BLOB_SIZE, 'absolute', 0.5, 'One blob: wrong blob radius');
    
function test_one_blob_with_noise
    IMG_SIZE = 128;
    BLOB_SIZE = 10;
    img = generate_blob([IMG_SIZE/2 IMG_SIZE/2], BLOB_SIZE, IMG_SIZE);
    noise = random('unif', min(img(:)), min(img(:)) + 0.3 * (max(img(:)) - min(img(:))), IMG_SIZE, IMG_SIZE);
    img = noise + img;
    [centers, radiuses] = detect_blobs(img, (BLOB_SIZE-2):0.25:(BLOB_SIZE+2));
    assertEqual(length(centers), 1);
    assertElementsAlmostEqual(centers{1}, [IMG_SIZE/2 IMG_SIZE/2], 'absolute', 1.5, 'One blob: wrong blob center');
    assertElementsAlmostEqual(radiuses{1}, BLOB_SIZE, 'absolute', 0.5, 'One blob: wrong blob radius');
    
function test_four_blobs
    IMG_SIZE = 256;
    img =       generate_blob([IMG_SIZE/4   IMG_SIZE/4], 7.5, IMG_SIZE);
    img = img + generate_blob([IMG_SIZE/4   3*IMG_SIZE/4], 10, IMG_SIZE);
    img = img + generate_blob([3*IMG_SIZE/4 IMG_SIZE/4], 12.5, IMG_SIZE);
    img = img + generate_blob([3*IMG_SIZE/4 3*IMG_SIZE/4], 17.5, IMG_SIZE);
    [centers, radiuses] = detect_blobs(img, 5:0.5:20);
    assertEqual(length(centers), 4);
    assertElementsAlmostEqual(centers{1}, [IMG_SIZE/4   IMG_SIZE/4], 'absolute', 1.5, 'Four blobs: wrong blob 1 center');
    assertElementsAlmostEqual(centers{2}, [IMG_SIZE/4   3*IMG_SIZE/4], 'absolute', 1.5, 'Four blobs: wrong blob 2 center');
    assertElementsAlmostEqual(centers{3}, [3*IMG_SIZE/4 IMG_SIZE/4], 'absolute', 1.5, 'Four blobs: wrong blob 3 center');
    assertElementsAlmostEqual(centers{4}, [3*IMG_SIZE/4 3*IMG_SIZE/4], 'absolute', 1.5, 'Four blobs: wrong blob 4 center');
    assertElementsAlmostEqual(radiuses{1}, 7.5, 'absolute', 1.0, 'Four blobs: wrong blob 1 radius');
    assertElementsAlmostEqual(radiuses{2}, 10, 'absolute', 1.0, 'Four blobs: wrong blob 2 radius');
    assertElementsAlmostEqual(radiuses{3}, 12.5, 'absolute', 1.0, 'Four blobs: wrong blob 3 radius');
    assertElementsAlmostEqual(radiuses{4}, 17.5, 'absolute', 1.0, 'Four blobs: wrong blob 4 radius');
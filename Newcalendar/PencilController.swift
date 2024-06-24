import UIKit
import AVFAudio
import Vision
import PencilKit


class PencilController: UIViewController, PKCanvasViewDelegate,PKToolPickerObserver , UIGestureRecognizerDelegate, UITextViewDelegate {

    private var synthesizer = AVSpeechSynthesizer()
    var canvasView: PKCanvasView!
    var toolPicker: PKToolPicker!
    var progressView: UIProgressView!
    var segmentedControl:UISegmentedControl?
    var resultString = ""
    var speakStringLocation = 0
    var languageStr:String?
    var scrollView: UIScrollView!
    var timer: Timer?
    var id = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create UIScrollView
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: view.bounds.width, height: view.bounds.height * 10)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(scrollView)
        
        // Create PKCanvasView
        canvasView = PKCanvasView(frame: CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height))
        scrollView.addSubview(canvasView)
        
        scrollView.isScrollEnabled = false
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
            scrollView.addGestureRecognizer(pinchGestureRecognizer)
        
        canvasView.delegate = self
        canvasView.drawingPolicy = .anyInput
        canvasView.isUserInteractionEnabled = true

        // Add reset button
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("↩︎", for: .normal)
        resetButton.addTarget(self, action: #selector(returnToDataView), for: .touchUpInside)
        view.addSubview(resetButton)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            resetButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

        // Add reset strokes button
        let resetStrokeButton = UIButton(type: .system)
        resetStrokeButton.setTitle("Reset", for: .normal)
        resetStrokeButton.addTarget(self, action: #selector(resetCanvas), for: .touchUpInside)
        view.addSubview(resetStrokeButton)
        resetStrokeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resetStrokeButton.trailingAnchor.constraint(equalTo: resetButton.leadingAnchor, constant: -20),
            resetStrokeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])

        
        
        // Load drawing if available
        if let loadedDrawingData = loadDrawingFromFile(filename: id) {
            do {
                let drawing = try PKDrawing(data: loadedDrawingData)
                canvasView.drawing = drawing
            } catch {
                print("Error loading drawing data: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //
        toolPicker = PKToolPicker()
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(self)
        configureCanvas()
        canvasView.becomeFirstResponder()
        toolPicker.setVisible(true, forFirstResponder: canvasView)
    }

    
    func saveData() {
            let drawingData = canvasView.drawing.dataRepresentation()
            saveDrawingToFile(drawingData: drawingData)
        }
        

    func saveDrawingToFile(drawingData: Data) {
        // Get the path to the Documents directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Create a file URL
        let filename = id + ".dat"
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        
        do {
            // Write the data to the file
            try drawingData.write(to: fileURL)
            print("Drawing data saved successfully at \(fileURL.path)")
        } catch {
            print("Error saving drawing data: \(error.localizedDescription)")
        }
    }
    
    func loadDrawingFromFile(filename:String) -> Data? {
        // Get the path to the Documents directory
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        // Create a file URL with the same file name and extension
        let filename = filename + ".dat"
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        
        do {
            // Read the data from the file
            let drawingData = try Data(contentsOf: fileURL)
            return drawingData
        } catch {
            return nil
        }
    }

    
    @objc func canvasTapped(_ gestureRecognizer: UITapGestureRecognizer) {
       // Handle canvas tap here
       let location = gestureRecognizer.location(in: canvasView)
       if gestureRecognizer.state == .ended {
           print("Canvas tapped at location: \(location)")
           let alertController = UIAlertController(title: "Create Button", message: "Are you sure you want to create a button at this location?", preferredStyle: .alert)
              alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              alertController.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
                  self._createButton(_x: Int(location.x), _y: Int(location.y))
              }))
              present(alertController, animated: true, completion: nil)
       }
    }
    
    
    func startTimer() {
            // Invalidate any existing timer
            timer?.invalidate()
            
            // Schedule a new timer to fire after 2 seconds
            timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
                // This block of code will be executed when the timer fires
                self.timerFired()
            }
        }
        
    func timerFired() {
        // Do something when the timer fires
        print("Timer fired after 2 seconds!")
        scrollView.isScrollEnabled = false
    }
    
    @objc func handlePinchGesture(_ recognizer: UIPinchGestureRecognizer) {
            guard let view = recognizer.view else { return }
        scrollView.isScrollEnabled = true
        startTimer()

    }
    
    
    @objc func keyboardWillHide() {
        // Keyboard will hide, perform actions here
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.canvasView.becomeFirstResponder()
        }
    }

    deinit {
        // Unregister notification when view controller is deallocated
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func nextLine() {
        let linesArray = resultString.components(separatedBy: "\n").filter { !$0.isEmpty }
        
        if linesArray.count > speakStringLocation + 1{
            speakStringLocation += 1
            let utterance = AVSpeechUtterance(string: linesArray[speakStringLocation])
            let voices = AVSpeechSynthesisVoice.speechVoices()
            //print(voices)
            utterance.voice = AVSpeechSynthesisVoice(language: languageStr ?? "en-US")
            synthesizer.speak(utterance)
            print(linesArray[speakStringLocation])
        }
    }
    
    @objc func prevLine() {
        let linesArray = resultString.components(separatedBy: "\n").filter { !$0.isEmpty }
        if linesArray.count > speakStringLocation - 1 && speakStringLocation - 1 > -1 {
            speakStringLocation -= 1
            let utterance = AVSpeechUtterance(string: linesArray[speakStringLocation])
            let voices = AVSpeechSynthesisVoice.speechVoices()
            //print(voices)
            utterance.voice = AVSpeechSynthesisVoice(language: languageStr ?? "en-US")
            synthesizer.speak(utterance)
            print(linesArray[speakStringLocation])
        }
    }
    
    //
    @objc func ttsPlay() {
        // Handle segmented control value change
        let linesArray = resultString.components(separatedBy: "\n").filter { !$0.isEmpty }
        if linesArray.count > speakStringLocation{
            let txt = linesArray[speakStringLocation]
            let utterance = AVSpeechUtterance(string: linesArray[speakStringLocation])
            let voices = AVSpeechSynthesisVoice.speechVoices()
            //print(voices)
            utterance.voice = AVSpeechSynthesisVoice(language: languageStr ?? "en-US")
            synthesizer.speak(utterance)
            print(linesArray[speakStringLocation])
        }
    }
    
  
    
    @objc func returnToDataView() {
        saveData()
        let target = storyboard!.instantiateViewController(withIdentifier: "mainview") as! MainViewController
        target.modalPresentationStyle = .fullScreen
        present(target, animated: true, completion: nil)
    }
    
    @objc func resetCanvas() {
        canvasView.drawing = PKDrawing()
    }
    
    func toolPickerSelectedToolDidChange(_ toolPicker: PKToolPicker) {
            // This method is called when the selected tool in the tool picker changes
            let selectedTool = toolPicker.selectedTool
            
            // Perform actions based on the selected tool
            print("Selected tool changed to:", selectedTool)
            // Perform actions based on the active tool
            canvasView.tool = selectedTool
            switch selectedTool {
            case is PKInkingTool:
                // The active tool is an inking tool (pen)
                print("Using pen tool")
            case is PKEraserTool:
                // The active tool is an eraser
                print("Using eraser tool")
            case is PKLassoTool:
                // The active tool is a lasso (selection) tool
                print("Using lasso tool")
            default:
                // Default case if no specific tool is identified
                print("Using default tool")
            }
        
        
        }
    

    
    func configureCanvas() {
        let penTool = PKInkingTool(.pen, color: .black, width: 1) // Adjust width as needed
        canvasView.tool = penTool
        canvasView.minimumZoomScale = 1.0
        canvasView.maximumZoomScale = 1.0
        
        // Set other canvas configurations
        if #available(iOS 14.0, *) {
            canvasView.drawingPolicy = .anyInput
        }
        canvasView.allowsFingerDrawing = true

//        canvasView.layer.borderWidth = 2.0 // Choose your desired border width
//        canvasView.layer.borderColor = UIColor.black.cgColor // Choose your desired border color
//        canvasView.layer.cornerRadius = 10.0
        
        // You can also set initial tool and observe changes like this:
        canvasView.addObserver(self, forKeyPath: "tool", options: .new, context: nil)
    }
           
    

    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()

           // Update the canvasView frame to match the scrollView contentSize
           canvasView.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
       }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "tool" {
                // Handle tool change
                if let newTool = change?[.newKey] as? PKTool {
                    print("Tool changed to:", newTool)
                    // Do something with the new tool
                }
            }
        }
    
   
    
    func _createButton(_x:Int,_y:Int){
        // Create a button
        let button = UIButton(type: .system)
        
        // Set the title for the button
        let iconImage = UIImage(systemName: "info.circle.fill")
        button.setImage(iconImage, for: .normal)
        
        
        // Set the frame (position and size) for the button
        button.frame = CGRect(x: _x, y: _y, width: 50, height: 50)
        
        // Add an action (function to be called when the button is tapped)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        button.tag = Int.random(in: 1...100)
        // Add the button to the view
        canvasView.addSubview(button)
    }
    
    // Function to be called when the button is tapped
    @objc func buttonTapped(_ sender: UIButton) {
        print("Button tapped with tag: \(sender.tag)")
    }

    func _performOCR(on image: UIImage) {
        // Use an OCR library or service to extract text from the image
        // Example using Vision framework
        let request = VNRecognizeTextRequest(completionHandler: { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                print("Recognized text:", topCandidate.string)
                self.resultString += topCandidate.string
                //no self.resetCanvas()
                
                
                
            }
        })
        
        // Set the recognition languages to Japanese ja
        let name = segmentedControl?.titleForSegment(at: segmentedControl!.selectedSegmentIndex)
        
        if let unwrappedName = name {
            request.recognitionLanguages = [unwrappedName]
            let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
            do {
                try handler.perform([request])
            } catch {
                print("Error performing OCR:", error)
            }
        }
    }
       
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Check if the return key is pressed
      
        resultString = textView.text
        // You can dismiss the keyboard or perform any other action
        //textView.resignFirstResponder() // Dismiss keyboard
        let linesArray = resultString.components(separatedBy: "\n").filter { !$0.isEmpty }
        
        print(linesArray)
        speakStringLocation = 0
            
            
        return true // Allow other text changes
    }
    
    private func speakText(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        let voices = AVSpeechSynthesisVoice.speechVoices()
        //print(voices)
           utterance.voice = AVSpeechSynthesisVoice(language: languageStr)
        synthesizer.speak(utterance)
        print(text)
    }
    
    private func saveDataOnUserdefault(text:String){
        var (savedLanguageIdxArray, savedTextArray) = loadDataFromUserDefaults()

        let dup = savedTextArray?.firstIndex(of: text)
        
        if (dup == nil && (savedLanguageIdxArray != nil) && (savedTextArray != nil) ){
            // Append new values to the arrays
            var languageIdxArray = savedLanguageIdxArray!
            languageIdxArray.append(segmentedControl?.selectedSegmentIndex ?? 0)
            
            var textArray = savedTextArray!
            textArray.append(text)
            
            // Save the modified arrays back to UserDefaults
            UserDefaults.standard.set(languageIdxArray, forKey: "language")
            UserDefaults.standard.set(textArray, forKey: "quote")
            UserDefaults.standard.synchronize()
        }
        
        if (savedLanguageIdxArray == nil) && (savedTextArray == nil){
            var intAry = [Int]()
            var stringAry = [String]()
            intAry.append(segmentedControl?.selectedSegmentIndex ?? 0)
            stringAry.append(text)
            
            let language = UserDefaults.standard
            language.set(intAry, forKey: "language")
            language.synchronize()
            
            let content = UserDefaults.standard
            content.set(stringAry, forKey: "quote")
            content.synchronize()
        }
        
        //change language
        if (segmentedControl?.selectedSegmentIndex != nil) && (dup != nil) && (savedLanguageIdxArray != nil) && (savedTextArray != nil){
            savedLanguageIdxArray![dup!] = segmentedControl!.selectedSegmentIndex
            let language = UserDefaults.standard
            language.set(savedLanguageIdxArray, forKey: "language")
            language.synchronize()
        }
    }
    
    private func loadDataFromUserDefaults() -> (languageIdxArray: [Int]?, textArray: [String]?) {
        let defaults = UserDefaults.standard
        
        // Retrieve language index array
        let languageIdxArray = defaults.array(forKey: "language") as? [Int]
        
        // Retrieve text array
        let textArray = defaults.array(forKey: "quote") as? [String]
        
        return (languageIdxArray, textArray)
    }



    
}
extension UIView {
    func screenshot() -> UIImage? {
        // Begin the graphics context
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        // Render the view hierarchy to the current context
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        
        // Get the image from the current context
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the graphics context
        UIGraphicsEndImageContext()
        
        return screenshot
    }
}


class CustomCanvasView: PKCanvasView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            let location = touch.location(in: self)
            print("Touch began at: \(location)")
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first {
            let location = touch.location(in: self)
            print("Touch moved to: \(location)")
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let touch = touches.first {
            let location = touch.location(in: self)
            print("Touch ended at: \(location)")
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        if let touch = touches.first {
            let location = touch.location(in: self)
            print("Touch cancelled at: \(location)")
        }
    }
    
    func shrinkStrokes(by factor: CGFloat) {
        guard factor > 0 else { return }

        var newStrokes = [PKStroke]()

        for stroke in self.drawing.strokes {
            let originalLength = stroke.path.length()
            let newPath = stroke.path.resampled(to: originalLength / factor)
            let newStroke = PKStroke(ink: stroke.ink, path: newPath, transform: stroke.transform, mask: stroke.mask)
            newStrokes.append(newStroke)
        }

        // Set the new drawing with shrunken strokes
        self.drawing = PKDrawing(strokes: newStrokes)
    }
    
    func addStroke(at points: [CGPoint], with color: UIColor = .black, width: CGFloat = 5.0) {
            let newStroke = createStroke(at: points, with: color, width: width)
            var currentDrawing = self.drawing
            currentDrawing.strokes.append(newStroke)
            self.drawing = currentDrawing
    }
    
    func createStroke(at points: [CGPoint], with color: UIColor = .black, width: CGFloat = 5.0) -> PKStroke {
        let ink = PKInk(.pen, color: color)
        var controlPoints = [PKStrokePoint]()

        for point in points {
            let strokePoint = PKStrokePoint(location: point, timeOffset: 0, size: CGSize(width: width, height: width), opacity: 1.0, force: 1.0, azimuth: 0, altitude: 0)
            controlPoints.append(strokePoint)
        }

        let path = PKStrokePath(controlPoints: controlPoints, creationDate: Date())
        let stroke = PKStroke(ink: ink, path: path, transform: .identity, mask: nil)

        return stroke
    }
    
}

extension PKStrokePath {
    func length() -> CGFloat {
        guard self.count > 1 else { return 0 }

        var totalLength: CGFloat = 0.0
        var previousPoint = self[0].location

        for i in 1..<self.count {
            let currentPoint = self[i].location
            let distance = hypot(currentPoint.x - previousPoint.x, currentPoint.y - previousPoint.y)
            totalLength += distance
            previousPoint = currentPoint
        }

        return totalLength
    }
    
    func resampled(to targetLength: CGFloat) -> PKStrokePath {
        let originalLength = self.length()
        guard originalLength > 0 else { return self }
        
        let scale = targetLength / originalLength
        var newPoints = [PKStrokePoint]()
        
        for i in 0..<self.count {
            let point = self[i]
            let newLocation = CGPoint(x: point.location.x * scale, y: point.location.y * scale)
            let newPoint = PKStrokePoint(location: newLocation, timeOffset: point.timeOffset, size: point.size, opacity: point.opacity, force: point.force, azimuth: point.azimuth, altitude: point.altitude)
            newPoints.append(newPoint)
        }
        
        return PKStrokePath(controlPoints: newPoints, creationDate: Date())
    }
}

//
//  UploadViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 17/02/2025.
//
//
//  UploadViewController.swift
//  LoopLyfe
//
//  Created by Naveed Khalid on 17/02/2025.
//

import UIKit
import AVFoundation

class UploadViewController: UIViewController {

    // MARK: - Camera Properties
    private var captureSession: AVCaptureSession?
    private var videoOutput: AVCaptureMovieFileOutput?
    private var previewLayer: AVCaptureVideoPreviewLayer?

    
    // MARK: - UI
    private let recordButton = UIView()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupCamera()
        setupRecordButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.bounds
    }

}

// MARK: - Camera Setup
extension UploadViewController {
    
    private func setupCamera() {
        let session = AVCaptureSession()
        session.sessionPreset = .high

        // 🎥 Video
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: .back),
              let videoInput = try? AVCaptureDeviceInput(device: camera)
        else { return }

        // 🎤 Audio
        guard let mic = AVCaptureDevice.default(for: .audio),
              let audioInput = try? AVCaptureDeviceInput(device: mic)
        else { return }

        if session.canAddInput(videoInput) { session.addInput(videoInput) }
        if session.canAddInput(audioInput) { session.addInput(audioInput) }

        let output = AVCaptureMovieFileOutput()
        if session.canAddOutput(output) { session.addOutput(output) }

        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = .resizeAspectFill
        preview.frame = view.bounds
        view.layer.insertSublayer(preview, at: 0)

        captureSession = session
        videoOutput = output
        previewLayer = preview

        session.startRunning()
    }

}

// MARK: - Record Button
extension UploadViewController {
    
    private func setupRecordButton() {
        let size: CGFloat = 80
        recordButton.frame = CGRect(
            x: (view.bounds.width - size) / 2,
            y: view.bounds.height - size - 60,
            width: size,
            height: size
        )
        
        recordButton.backgroundColor = .red
        recordButton.layer.cornerRadius = size / 2
        recordButton.layer.borderWidth = 6
        recordButton.layer.borderColor = UIColor.white.cgColor
        
        view.addSubview(recordButton)
        
        let longPress = UILongPressGestureRecognizer(
            target: self,
            action: #selector(handleRecordPress(_:))
        )
        longPress.minimumPressDuration = 0.1
        recordButton.addGestureRecognizer(longPress)
    }
    
    @objc private func handleRecordPress(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            startRecording()
            animateRecording(true)
        case .ended, .cancelled:
            stopRecording()
            animateRecording(false)
        default:
            break
        }
    }
}

// MARK: - Recording
extension UploadViewController {
    
    private func startRecording() {
        guard let videoOutput = videoOutput else { return }
        
        let path = NSTemporaryDirectory() + "\(UUID().uuidString).mov"
        let url = URL(fileURLWithPath: path)
        videoOutput.startRecording(to: url, recordingDelegate: self)
    }

    private func stopRecording() {
        videoOutput?.stopRecording()
    }

}

// MARK: - Recording Delegate
extension UploadViewController: AVCaptureFileOutputRecordingDelegate {
    
    func fileOutput(_ output: AVCaptureFileOutput,
                    didFinishRecordingTo outputFileURL: URL,
                    from connections: [AVCaptureConnection],
                    error: Error?) {
        
        if let error = error {
            print("❌ Recording error:", error)
            return
        }
        
        print("✅ Video recorded at:", outputFileURL)
        
        // Save to gallery (optional)
        UISaveVideoAtPathToSavedPhotosAlbum(
            outputFileURL.path,
            nil,
            nil,
            nil
        )
    }
}

// MARK: - Animations
extension UploadViewController {
    
    private func animateRecording(_ isRecording: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.recordButton.transform = isRecording
            ? CGAffineTransform(scaleX: 1.2, y: 1.2)
            : .identity
        }
    }
}

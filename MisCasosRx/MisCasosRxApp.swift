//
//  MisCasosRxApp.swift
//  MisCasosRx
//
//  Created by Diego Jaramillo Hernández on 10/05/22.
//

import SwiftUI
import AVKit
@main
struct MisCasosRxApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var clasificationIdentifier: String = ""
    @State var skip : Bool = false
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            if clasificationIdentifier == "Video Finished" {
                  ContentView()
                     .preferredColorScheme(.dark)
                     .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }else {
                ZStack{
                IntroVideo(identifier: $clasificationIdentifier)
                    .preferredColorScheme(.dark)
                    .ignoresSafeArea()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                skip = true
                            }
                        }
                    }
                    if skip {
                    HStack{
                        
                        Spacer()
                        Button {
                            withAnimation {
                                clasificationIdentifier = "Video Finished"
                            }
                        } label: {
                            VStack {
                            Text("Skip>>")
                                .foregroundColor(.white)
                                .padding(.horizontal , 10)
                                .padding(.vertical , 5)
                                .background(
                                
                                    Capsule().foregroundColor(.gray).opacity(0.2)
                                )
                                .padding()
                                
                                Spacer()
                                
                            }
                            
                        }
                        .opacity(0.8)
                    }
                    }
                    
                }
                
            }
      
            
        }
    }
}
struct IntroVideo: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(identifierBinding: identifier)
    }
    
    let identifier: Binding<String>
    func makeUIViewController(context: Context) -> some UIViewController {
      let vc =   VideoViewController()
        vc.delegate = context.coordinator
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        uiViewController.setV
    }
    class Coordinator: ViewControllerDelegate {
          let identifierBinding: Binding<String>
          
          init(identifierBinding: Binding<String>) {
              self.identifierBinding = identifierBinding
          }
          
          func clasificationOccured(_ viewController: VideoViewController, identifier: String) {
              // whenever the view controller notifies it's delegate about receiving a new idenfifier
              // the line below will propagate the change up to SwiftUI
              identifierBinding.wrappedValue = identifier
          }
      }
}

protocol ViewControllerDelegate: AnyObject {
    func clasificationOccured(_ viewController: VideoViewController, identifier: String)
}



class VideoViewController: UIViewController {

    var player: AVPlayer?
    weak var delegate: ViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadVideo()
        

        // Do any additional setup after loading the view, typically from a nib.
    }

    private func loadVideo() {

        //this line is important to prevent background music stop
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        } catch { }

        let path = Bundle.main.path(forResource: "intro", ofType:"mp4")
      //  print("path: \(path)")
        let filePathURL = NSURL.fileURL(withPath: path!)
        let player = AVPlayer(url: filePathURL)
        let playerLayer = AVPlayerLayer(player: player)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player.currentItem)

        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1

        self.view.layer.addSublayer(playerLayer)

        player.seek(to: CMTime.zero)
        player.play()
    }
    @objc func playerDidFinishPlaying(note: NSNotification) {
       // print("Video Finished")
        delegate?.clasificationOccured(self, identifier: "Video Finished")
    }
}

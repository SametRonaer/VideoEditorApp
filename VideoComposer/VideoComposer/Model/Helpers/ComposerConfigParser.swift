
import Foundation


class VideoComposerConfigParser{
    
    func parseConfigData(config: String) -> ComposerConfigModel?{
        let data = config.data(using: .utf8)!
        let decoder = JSONDecoder()
        do {
            let config = try decoder.decode(ComposerConfigModel.self, from: data)
            print(config)
            return config
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getComposerConfigViewModel(model: ComposerConfigModel) -> ComposerViewConfigModel{
        var sequences = [ComposerViewConfigSequenceModel]()
        model.sequences.forEach { seq in
            sequences.append(ComposerViewConfigSequenceModel(duration: seq.duration, type: seq.type))
        }
        let composerViewConfig = ComposerViewConfigModel(sequences: sequences, soundUrl: model.soundUrl)
        return composerViewConfig
    }
    
}


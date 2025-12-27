//
//  SearchTblViewCell.swift
//  LoopLyfe
//

import UIKit

class SearchTblViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPosts: UILabel!
    @IBOutlet weak var videosCollectionView: UICollectionView!

    // Videos array for this cell (from ViewController)
    var videos: [VideoElement] = [] {
        didSet {
            DispatchQueue.main.async {
                self.videosCollectionView.reloadData()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Setup Collection View
    private func setupCollectionView() {
        videosCollectionView.delegate = self
        videosCollectionView.dataSource = self
        videosCollectionView.register(UINib(nibName: "VideosCollectionView", bundle: nil), forCellWithReuseIdentifier: "VideosCollectionView")
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension SearchTblViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionView", for: indexPath) as! VideosCollectionView
        let videoElement = videos[indexPath.row]

        cell.videosImageView.image = UIImage(named: "placeholder")
        if let thumbURLString = videoElement.video?.thum, let url = URL(string: thumbURLString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.videosImageView.image = image
                    }
                }
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8
        let totalSpacing = spacing * 4
        let width = (collectionView.frame.width - totalSpacing) / 5
        return CGSize(width: width, height: 127)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

}


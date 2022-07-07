import UIKit

class NavigationViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            let home = HomeViewController()
            let homeItem = UITabBarItem(title: "Accueil", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
            
            home.tabBarItem = homeItem
            
        
            let search = SearchViewController()
            let searchItem = UITabBarItem(title: "Rechercher", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
            
            search.tabBarItem = searchItem
        
        
            let favorite = FavoriteViewController()
            let favoriteItem = UITabBarItem(title: "Favoris", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
            
            favorite.tabBarItem = favoriteItem
        
            let chat = ChatViewController()
            let chatItem = UITabBarItem(title: "Chat", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
            
            chat.tabBarItem = chatItem
            
            self.viewControllers = [home, search, favorite, chat]
        }

}


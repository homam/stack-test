module Pages
    (
      findAllFiles
    ) where
import System.Directory (getDirectoryContents, doesDirectoryExist)

data Tree a = Directory a [Tree a] | File a  deriving (Show)

traverseBF :: Tree a -> [a]
traverseBF tree = tbf [tree] where
    tbf [] = []
    tbf xs = concatMap files xs ++ tbf (concatMap directories xs)
    files (File a) = [a]
    files (Directory _ _) = []
    directories (File  _) = []
    directories (Directory _ ys) = ys

makeTheTree :: FilePath -> IO (Tree FilePath)
makeTheTree path = do
    isDirecotry <- doesDirectoryExist path
    if not isDirecotry then
        return $ File path
    else do
        content <- getDirectoryContents path
        tree <- mapM makeTheTree (processFiles content)
        return $ Directory path tree
    where
        processFiles :: [FilePath] -> [FilePath]
        processFiles files = map ((path ++) . ("/" ++)) $ discardDots files

discardDots :: [FilePath] -> [FilePath]
discardDots = filter (\file -> file /= "." && file /= "..")

findAllFiles :: FilePath -> FilePath -> IO [FilePath]
findAllFiles fileName path =
    let length' = length fileName
    in (filter ((== fileName) . reverse . take length' . reverse) . traverseBF <$> makeTheTree path)

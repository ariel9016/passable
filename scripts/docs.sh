cp ./README.md ./documentation/MAIN.md

node ./scripts/make_version_file.js
find ./documentation -type f > ./tree.txt
node ./scripts/add_version_to_files.js
npm i -g node-sass

passable_version=$(<version.txt)

git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_NAME

git clone -b $DOCS_BRANCH https://github.com/$GITHUB_REPO.git docs
rm -rf docs/*

npx docpress b
cd docs
node-sass assets/style -o assets/style --output-style compressed
rm -rf assets/style/**/*.scss

git add .
git commit -m "Updating Documentation: $passable_version"
git push https://${GITHUB_TOKEN}@github.com/$GITHUB_REPO.git $DOCS_BRANCH
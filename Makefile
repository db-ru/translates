init-public:
	git submodule add -b master git@github.com:db-ru/db-ru.github.io.git public

deploy:
	hugo
	cd public && \
		git add . && \
		git commit -m "update" && \
		git push origin master

dev:
	hugo server -D

@echo -----------------------------------------------------------------------------
@echo 开发环境打包
@echo -----------------------------------------------------------------------------
mvn clean package -Dmaven.test.skip=true -Pdev
@pause
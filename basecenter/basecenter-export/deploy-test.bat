@echo -----------------------------------------------------------------------------
@echo TEST
@echo -----------------------------------------------------------------------------
mvn deploy -Dmaven.test.skip=true -Ptest
@pause
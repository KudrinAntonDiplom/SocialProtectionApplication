package com.module.controllers.referencebook;

import com.module.controllers.FooterController;
import com.module.controllers.ProgressController;
import com.module.controllers.RootManager;
import com.module.database.DatabaseWorker;
import com.module.helpers.CustomAlertCreator;
import com.module.helpers.FileLoader;
import com.module.model.entity.WoundTypeEntity;
import com.module.xml.DatabaseChecker;
import com.module.xml.VeteransExchange;
import com.module.xml.XmlExporter;
import com.module.xml.XmlImporter;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.stage.Stage;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.IOException;
import java.util.Optional;

@Data
@Component
public class NewWoundTypeDialogController {
    @FXML
    private TableView<WoundTypeEntity> existsWoundTypesTable;
    @FXML
    private TableColumn<WoundTypeEntity, String> woundTypesColumn;
    @FXML
    private TextField newWoundTypeTextField;
    @FXML
    private Button saveButton;
    @FXML
    private Button editButton;
    @FXML
    private Button deleteButton;

    private DatabaseWorker databaseWorker;

    private DatabaseChecker databaseChecker;

    private ObservableList<WoundTypeEntity> woundTypeData = FXCollections.observableArrayList();

    private Stage dialogStage;

    private WoundTypeEntity selectedItem;
    private int selectedIndex;

    @FXML
    public void initialize() {
        woundTypesColumn.setCellValueFactory(new PropertyValueFactory<>("type"));
        existsWoundTypesTable.setItems(woundTypeData);

        existsWoundTypesTable.getSelectionModel().selectedItemProperty().addListener((obs, oldSelection, newSelection) -> {
            if (newSelection != null && databaseWorker.isAdmin()) {
                editButton.setDisable(false);
                deleteButton.setDisable(false);
            } else {
                editButton.setDisable(true);
                deleteButton.setDisable(true);
            }
        });
        newWoundTypeTextField.textProperty().addListener((observable, oldValue, newValue) -> {
            if (!newValue.trim().isEmpty() && databaseWorker.isAdmin())
                saveButton.setDisable(false);
            else saveButton.setDisable(true);
        });
    }

    public void setDialogStage(Stage dialogStage) {
        this.dialogStage = dialogStage;
    }

    @FXML
    private void handleCloseButton() {
        dialogStage.close();
    }

    @FXML
    private void handleDeleteButton() {
        int selectedIndex = existsWoundTypesTable.getSelectionModel().getSelectedIndex();
        WoundTypeEntity selectedItem = existsWoundTypesTable.getSelectionModel().getSelectedItem();

        if (selectedIndex >= 0) {
            CustomAlertCreator customAlertCreator = new CustomAlertCreator();
            Optional<ButtonType> result = customAlertCreator.createDeleteConfirmationAlert().showAndWait();

            if (result.get() == customAlertCreator.getButtonTypeOk()) {
                woundTypeData.remove(selectedIndex);
                databaseWorker.deleteWoundType(selectedItem);
                existsWoundTypesTable.refresh();
            }
        }
    }

    @FXML
    private void handleEditButton() {
        this.selectedIndex = existsWoundTypesTable.getSelectionModel().getSelectedIndex();
        if (selectedIndex >= 0) {
            this.selectedItem = existsWoundTypesTable.getSelectionModel().getSelectedItem();
            newWoundTypeTextField.setText(selectedItem.getType());
        }
    }

    @FXML
    private void handleSaveButton() {
        if (this.selectedItem == null) {
            selectedItem = new WoundTypeEntity(newWoundTypeTextField.getText());
            woundTypeData.add(selectedItem);
        } else {
            selectedItem.setType(newWoundTypeTextField.getText());
            woundTypeData.set(selectedIndex, selectedItem);
        }
        databaseWorker.saveWoundType(selectedItem);
        selectedItem = null;
        newWoundTypeTextField.clear();
        existsWoundTypesTable.refresh();
    }
}


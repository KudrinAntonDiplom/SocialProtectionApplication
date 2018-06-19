package com.module.controllers;

import com.module.model.entity.VeteranEntity;
import javafx.beans.property.ObjectProperty;
import javafx.beans.property.SimpleObjectProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.SortedList;
import javafx.fxml.FXML;
import javafx.scene.control.SelectionMode;
import javafx.scene.control.TableCell;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import lombok.Data;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Comparator;
import java.util.LinkedList;

@Data
@Component
public class MainTableController {

    @FXML
    private TableColumn<VeteranEntity, String> addressColumn;
    @FXML
    private TableColumn<VeteranEntity, String> caseNumberColumn;
    @FXML
    private TableColumn<VeteranEntity, String> categoryColumn;
    @FXML
    private TableColumn<VeteranEntity, LocalDate> dateOfBirthColumn;
    @FXML
    private TableColumn<VeteranEntity, String> districtColumn;
    @FXML
    private TableColumn<VeteranEntity, String> firstNameColumn;
    @FXML
    private TableColumn<VeteranEntity, String> lastNameColumn;
    @FXML
    private TableView<VeteranEntity> mainTable;
    @FXML
    private TableColumn<VeteranEntity, String> middleNameColumn;
    @FXML
    private TableColumn<VeteranEntity, String> militaryRankColumn;
    @FXML
    private TableColumn<VeteranEntity, String> subcategoryColumn;
    @FXML
    private TableColumn<VeteranEntity, String > militaryPositionColumn;
    @FXML
    private TableColumn<VeteranEntity, String > marchingOrganizationColumn;
    @FXML
    private  TableColumn<VeteranEntity, String> villageExecutiveCommitteeColumn;
    @FXML
    private  TableColumn<VeteranEntity, String> regionalExecutiveCommitteeColumn;
    @FXML
    private  TableColumn<VeteranEntity, String> rgvkColumn;
    @FXML
    private  TableColumn<VeteranEntity, String> subdivisionColumn;

    private ObservableList<VeteranEntity> veteransData = FXCollections.observableArrayList();

    public void addToTable(VeteranEntity veteranEntity) {
        veteransData.add(veteranEntity);
        mainTable.refresh();
    }

    public LinkedList<VeteranEntity> getSelectedVeterans() {
        return new LinkedList<>(mainTable.getSelectionModel().getSelectedItems());
    }

    public void refreshTable() {
        mainTable.refresh();
    }

    @FXML
    private void initialize() {
        caseNumberColumn.setCellValueFactory(new PropertyValueFactory<>("caseNumber"));
        caseNumberColumn.setComparator(new CustomComparator());
        militaryRankColumn.setCellValueFactory(new PropertyValueFactory<>("militaryRank"));
        lastNameColumn.setCellValueFactory(new PropertyValueFactory<>("secondName"));
        firstNameColumn.setCellValueFactory(new PropertyValueFactory<>("firstName"));
        middleNameColumn.setCellValueFactory(new PropertyValueFactory<>("middleName"));


        dateOfBirthColumn.setCellValueFactory(new PropertyValueFactory<>("dateOfBirth"));
        dateOfBirthColumn.setCellFactory((TableColumn<VeteranEntity, LocalDate> column) -> new TableCell<VeteranEntity, LocalDate>() {
            @Override
            protected void updateItem(LocalDate item, boolean empty) {
                super.updateItem(item, empty);
                if (item == null || empty) {
                    setText(null);
                } else {
                    setText(item.format(DateTimeFormatter.ofPattern("dd.MM.yyyy")));
                }
            }
        });

        categoryColumn.setCellValueFactory(new PropertyValueFactory<>("category"));
        districtColumn.setCellValueFactory(new PropertyValueFactory<>("district"));
        addressColumn.setCellValueFactory(new PropertyValueFactory<>("address"));
        subcategoryColumn.setCellValueFactory(new PropertyValueFactory<>("subcategory"));
        militaryPositionColumn.setCellValueFactory(new PropertyValueFactory<>("position"));
        marchingOrganizationColumn.setCellValueFactory(new PropertyValueFactory<>(" marchingOrganization"));
        villageExecutiveCommitteeColumn.setCellValueFactory(new PropertyValueFactory<>("villageExecutiveCommittee"));
        regionalExecutiveCommitteeColumn.setCellValueFactory(new PropertyValueFactory<>("regionalExecutiveCommittee"));
        rgvkColumn.setCellValueFactory(new PropertyValueFactory<>("rgvk"));
        subdivisionColumn.setCellValueFactory(new PropertyValueFactory<>("subdivision"));

        mainTable.setItems(veteransData);
        mainTable.getSelectionModel().setSelectionMode(SelectionMode.MULTIPLE);
    }

    private class CustomComparator implements Comparator<String>{

        @Override
        public int compare(String o1, String o2) {
            if (o1 == null && o2 == null) return 0;
            if (o1 == null) return -1;
            if (o2 == null) return 1;

            Integer i1=null;
            try{ i1=Integer.valueOf(o1); } catch(NumberFormatException ignored){}
            Integer i2=null;
            try{ i2=Integer.valueOf(o2); } catch(NumberFormatException ignored){}

            if(i1==null && i2==null) return o1.compareTo(o2);
            if(i1==null) return -1;
            if(i2==null) return 1;

            return i1-i2;
        }
    }

    VeteranEntity getSelectedVeteran() {
        return mainTable.getSelectionModel().getSelectedItem();
    }
}

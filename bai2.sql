USE rikkeiclinicdb;

-- mã nguồn mẫu 
DELIMITER //
CREATE PROCEDURE TransferBed(IN p_patient_id INT, IN p_new_bed_id INT)
BEGIN
    UPDATE Beds SET patient_id = NULL WHERE patient_id = p_patient_id;
    UPDATE Beds SET patient_id = p_patient_id WHERE bed_id = p_new_bed_id;
END //
DELIMITER ;
-- phần A
-- Giải thích ngắn gọn về tính chất ACID
-- Tính chất này bắt buộc tất cả các thao tác trong một giao dịch phải cùng thành công hoặc cùng thất bại, 
-- không được phép dừng lại ở trạng thái nửa vời làm mất thông tin giường của bệnh nhân.

-- pần B
DROP PROCEDURE IF EXISTS TransferBed;

DELIMITER //
CREATE PROCEDURE TransferBed(IN p_patient_id INT, IN p_new_bed_id INT)
BEGIN
    START TRANSACTION;
    UPDATE Beds 
    SET patient_id = NULL 
    WHERE patient_id = p_patient_id;
    UPDATE Beds 
    SET patient_id = p_patient_id 
    WHERE bed_id = p_new_bed_id;
    COMMIT;
END //
DELIMITER ;

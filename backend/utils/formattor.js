function convertToPostgresDate(dateStr, addHours = 0) {
    const [datePart, timePart] = dateStr.split(' ');
    const [day, month, year] = datePart.split('/').map(Number);
    const [hours, minutes] = timePart.split(':').map(Number);
    timezoneOffset = 8;

    // Create a new Date object
    const date = new Date(year, month - 1, day, hours + addHours, minutes);
    date.setHours(date.getHours() + timezoneOffset);
    
    // Return the date in ISO format (YYYY-MM-DDTHH:mm:ss)
    return date.toISOString(); // Adjust if you need a specific format
  }
  module.exports = {
    convertToPostgresDate
};